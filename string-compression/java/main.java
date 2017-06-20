import java.util.Scanner;

public class main {
    
    public static void main(String args[]) {
        Scanner in = new Scanner(System.in);
        while (in.hasNextLine()) {
            String s = in.nextLine();
            System.out.println(compress(s));
        }
    }

    static String compress(String s) {
        if (s.length() < 3)
            return s;
        int count = 1;
        Character prev = s.charAt(0);
        StringBuilder out = new StringBuilder(s.length() * 2);
        for (int pos = 1; pos < s.length(); pos++) {
            if (s.charAt(pos) != prev) {
                out.append(prev);
                out.append(count);
                prev = s.charAt(pos);
                count = 1;
            } else {
                count++;
            }
        }
        out.append(prev);
        out.append(count);
        if (out.length() < s.length())
            return out.toString();
        return s;
    }

}
