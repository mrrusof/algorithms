import java.util.Scanner;
import java.util.HashMap;

public class main {
    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(in.hasNextInt()) {
            int x = in.nextInt();
            int y = in.nextInt();
            int n = in.nextInt();
            HashMap<Integer, Integer> p = new HashMap<>();
            while(n > 0) {
                int a = in.nextInt();
                int b = in.nextInt();
                p.put(b, a);
                n -= 1;
            }
            System.out.println(mostRecentCommonAncestor(x, y, p));
        }
    }

    private static int mostRecentCommonAncestor(int a, int b, HashMap<Integer, Integer> p) {
        int da = depth(a, p);
        int db = depth(b, p);
        if(da < db) {
            int diff = db - da;
            while(diff > 0) {
                b = p.get(b);
                diff -= 1;
            }
        } else if(db < da) {
            int diff = da - db;
            while(diff > 0) {
                a = p.get(a);
                diff -= 1;
            }
        }
        while(a != b) {
            a = p.get(a);
            b = p.get(b);
        }
        return a;
    }

    private static int depth(int n, HashMap<Integer, Integer> p) {
        int i = 0;
        while(p.containsKey(n)) {
            n = p.get(n);
            i += 1;
        }
        return i;
    }
}
