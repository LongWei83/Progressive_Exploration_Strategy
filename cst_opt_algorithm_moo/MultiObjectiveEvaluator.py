class MultiObjectiveEvaluator:
    @staticmethod
    def dominates(p1, p2):
        """判断 p1 是否支配 p2"""
        better_or_equal = (
            p1.shuntImpedance >= p2.shuntImpedance and
            p1.qFactor >= p2.qFactor and
            abs(p1.frequency-5.71) <= abs(p2.frequency-5.71)
        )
        strictly_better = (
            p1.shuntImpedance > p2.shuntImpedance or
            p1.qFactor > p2.qFactor or
            abs(p1.frequency-5.71) < abs(p2.frequency-5.71)
        )
        return better_or_equal and strictly_better

    @staticmethod
    def non_dominated_sort(personals):
        """非支配排序"""
        fronts = []
        S = {}
        n = {}
        rank = {}

        for p in personals:
            S[p] = []
            n[p] = 0
            for q in personals:
                if p == q:
                    continue
                if MultiObjectiveEvaluator.dominates(p, q):
                    S[p].append(q)
                elif MultiObjectiveEvaluator.dominates(q, p):
                    n[p] += 1
            if n[p] == 0:
                rank[p] = 0
                if len(fronts) == 0:
                    fronts.append([])
                fronts[0].append(p)

        i = 0
        while i < len(fronts):
            next_front = []
            for p in fronts[i]:
                for q in S[p]:
                    n[q] -= 1
                    if n[q] == 0:
                        rank[q] = i + 1
                        next_front.append(q)
            if next_front:
                fronts.append(next_front)
            i += 1

        return fronts, rank

    @staticmethod
    def calculate_crowding_distance(front):
        """计算一个前沿层的拥挤距离"""
        l = len(front)
        if l == 0:
            return

        for p in front:
            p.crowding_distance = 0

        objectives = [
            ('shuntImpedance', True),
            ('qFactor', True),
            ('frequency', False),
        ]

        for key, is_max in objectives:
            if key == 'frequency':
                # 特别处理频率目标（越接近 5.71 越好）
                front.sort(key=lambda x: abs(getattr(x, key) - 5.71))
                values = [abs(getattr(p, key) - 5.71) for p in front]
            else:
                front.sort(key=lambda x: getattr(x, key), reverse=is_max)
                values = [getattr(p, key) for p in front]
            min_val = min(values)
            max_val = max(values)
            range_val = max_val - min_val if max_val != min_val else 1e-12
            for i in range(1, l - 1):
                prev_val = getattr(front[i - 1], key)
                next_val = getattr(front[i + 1], key)
                front[i].crowding_distance += abs(next_val - prev_val) / range_val

    @staticmethod
    def calculate_all_fitness(personals):
        """整体评估入口"""
        fronts, rank = MultiObjectiveEvaluator.non_dominated_sort(personals)

        for i, front in enumerate(fronts):
            for p in front:
                p.rank = i
            MultiObjectiveEvaluator.calculate_crowding_distance(front)

        # 综合排序依据（也可只用 rank）
        for p in personals:
            if p.roverQ > 20:
            # 注意：fitness 越小越优（rank 越小越好，距离越大越好）
                p.moo_fitness = (p.rank, -p.crowding_distance)
            else:
                p.moo_fitness = (p.rank+100, -p.crowding_distance)
