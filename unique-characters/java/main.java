import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(in.hasNextLine()) {
            if (isAllUniqueChars(in.nextLine()))
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

    private static boolean isAllUniqueChars(String s) {
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

}
