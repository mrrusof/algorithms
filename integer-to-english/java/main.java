import java.util.Scanner;

public class main {

    public static void main(String args[]) {
        Scanner in = new Scanner(System.in);

        while(in.hasNextInt()) {
            int n = in.nextInt();
            System.out.println(intToEnglish(n));
        }
    }

    // Copied from handwriting, not the fastest code...

    static String intToEnglish(int n) {
        StringBuilder prev = new StringBuilder();
        StringBuilder curr = new StringBuilder();
        int group = 0;

        if (n == 0) return "Zero";

        while(n > 0) {
            int tens_and_unit = n % 100;
            int h = (n % 1000) / 100;
            if (h > 0)
                curr.append(hundreds(h));
            if (tens_and_unit > 0) {
                if (h > 0)
                    curr.append(" ");
                curr.append(oneTo99(tens_and_unit));
            }
            n = n / 1000;
            if (group > 0) {
                curr.append(sep(group));
                if(prev.length() > 0)
                    curr.append(", ");
            }
            group++;
            prev = curr.append(prev);
            curr = new StringBuilder();
        }

        return prev.toString();
    }

    static StringBuilder sep(int n) {
        switch(n) {
        case 1:
            return new StringBuilder(" Thousand");
        case 2:
            return new StringBuilder(" Million");
        default:
            throw new RuntimeException("sep");
        }
    }

    static StringBuilder hundreds(int n) { // n > 0 and n < 10
        StringBuilder out = unit(n);
        return out.append(" Hundred");
    }

    static StringBuilder oneTo99(int n) {
        if (n < 10) 
            return unit(n);
        else if (n > 19) {  // ex 23
            int t = n / 10; // ex 2
            int u = n % 10; // ex 3
            StringBuilder out = new StringBuilder();
            if (t > 0)
                out.append(tens(t));
            if (n > 0) {
                if (t > 0)
                    out.append(" ");
                out.append(unit(u));
            }
            return out;
        } else {
            return teens(n);
        }
    }

    static StringBuilder teens(int n) {
        switch(n) {
        case 10:
            return new StringBuilder("Ten");
        case 11:
            return new StringBuilder("Eleven");
        case 12:
            return new StringBuilder("Twelve");
        case 13:
            return new StringBuilder("Thirteen");
        case 14:
            return new StringBuilder("Fourteen");
        case 15:
            return new StringBuilder("Fifteen");
        case 16:
            return new StringBuilder("Sixteen");
        case 17:
            return new StringBuilder("Seventeen");
        case 18:
            return new StringBuilder("Eighteen");
        case 19:
            return new StringBuilder("Nineteen");
        default:
            throw new RuntimeException("teens");
        }
    }

    static StringBuilder unit(int n) {
        switch(n) {
        case 1: return new StringBuilder("One");
        case 2: return new StringBuilder("Two");
        case 3: return new StringBuilder("Three");
        case 4: return new StringBuilder("Four");
        case 5: return new StringBuilder("Five");
        case 6: return new StringBuilder("Six");
        case 7: return new StringBuilder("Seven");
        case 8: return new StringBuilder("Eight");
        case 9: return new StringBuilder("Nine");
        default: throw new RuntimeException("unit");
        }
    }

    static StringBuilder tens(int n) {
        switch(n) {
        case 2: return new StringBuilder("Twenty");
        case 3: return new StringBuilder("Thirty");
        case 4: return new StringBuilder("Forty");
        case 5: return new StringBuilder("Fifty");
        case 6: return new StringBuilder("Sixty");
        case 7: return new StringBuilder("Seventy");
        case 8: return new StringBuilder("Eighty");
        case 9: return new StringBuilder("Ninety");
        default: throw new RuntimeException("tens");
        }
    }
}
