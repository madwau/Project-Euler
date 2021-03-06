import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Problem031 {
    public static void main(String[] args) {
        System.out.println(num(0, 200, new ArrayList<Integer>(Arrays.asList(1, 2, 5, 10, 20, 50, 100, 200))));
    }

    static int num(int sum, int max, List<Integer> coins) {
        // Target value has been matched: 1 solution found
        if (sum == max)
            return 1;

        // Target value cannot be matched anymore: 0 solutions found
        if (sum > max || coins.size() == 0)
            return 0;

        // 1st: Include current coin and leave remainingCoins unaltered
        // 2nd: Stop including current coin and move to next one
        return num(sum + coins.get(0), max, coins) + num(sum, max, coins.subList(1, coins.size()));
    }
}