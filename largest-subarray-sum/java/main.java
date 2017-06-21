import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(in.hasNextInt()) {
            int n = in.nextInt();
            int[] a = readArray(n, in);
            System.out.println(largestSum(a));
        }
    }

    static int[] readArray(int n, Scanner in) {
        int[] a = new int[n];
        for (int i = 0; i < n; i++) {
            a[i] = in.nextInt();
        }
        return a;
    }

    static int largestSum(int[] a) {
        if (a.length == 0)
            return 0;
        int lsh = 0; // largest sum here
        int lssf = a[0]; // largest sum so far
        for (int i = 0; i < a.length; i++) {
            lsh += a[i];
            if (lsh > lssf) {
                lssf = lsh;
            }
            if (lsh <= 0) {
                lsh = 0;
            }
        }
        return lssf;
    }

}
