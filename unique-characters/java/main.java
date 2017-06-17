import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(in.hasNextLine()) {
            //if (isAllUniqueCharsBitVector(in.nextLine()))
            if (isAllUniqueCharsSort(in.nextLine()))
                System.out.println("true");
            else
                System.out.println("false");
        }
    }

    // First shot...

    // private static boolean isAllUniqueChars(String s) {
    //     int n = s.length();
    //     int collected = 0;

    //     for(int i = 0; i < n; i++) {
    //         int bit = 1 << (code(s.charAt(i)) - code('a'));
    //         if ((collected & bit) > 0)
    //             return false;
    //         collected = collected | bit;
    //     }

    //     return true;
    // }

    // private static int code(Character c) {
    //     return Character.getNumericValue(c);
    // }

    private static boolean isAllUniqueCharsBitVector(String s) {
        int n = s.length();
        int collected = 0;

        for (int i = 0; i < n; i++) {
            int bit = 1 << s.charAt(i) - 'a';
            if ((collected & bit) > 0)
                return false;
            collected |= bit;
        }

        return true;
    }

    private static boolean isAllUniqueCharsSort(String input) {
        StringBuilder s = new StringBuilder(input);
        quicksort(s, 0, s.length() - 1);
        for (int i = 0; i < s.length() - 1; i++) {
            if (s.charAt(i) == s.charAt(i + 1))
                return false;
        }
        return true;
    }

    private static void quicksort(StringBuilder s, int l, int r) {
        if (r - l < 1) return;
        int m = partition(s, l, r);
        quicksort(s, l, m - 1);
        quicksort(s, m + 1, r);
    }

    private static int partition(StringBuilder s, int l, int r) {
        Character p = s.charAt(r--);
        int b = l;
        int e = r;
        while(l < r) {
            while(b < r && s.charAt(r) > p) r--;
            while(l < e && s.charAt(l) <= p) l++;
            if (l < r) swap(s, l, r);
        }
        swap(s, l, e + 1);
        return l;
    }

    private static void swap(StringBuilder s, int a, int b) {
        Character t = s.charAt(a);
        s.setCharAt(a, s.charAt(b));
        s.setCharAt(b, t);
    }

}
