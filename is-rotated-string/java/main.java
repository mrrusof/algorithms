import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(true) {
            if (! in.hasNextLine())
                break;
            String s1 = in.nextLine();
            if (! in.hasNextLine())
                break;
            String s2 = in.nextLine();
            System.out.println(isRotation(s1, s2));
        }
    }

    static boolean isRotation(String s1, String s2) {
        if (s1.length() != s2.length())
            return false;
        String s1s1 = s1 + s1;
        return isSubstring(s2, s1s1);
    }

    static boolean isSubstring(String s1, String s2) {
        return s2.indexOf(s1) > -1;
    }

}
