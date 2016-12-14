import java.util.Arrays;

public class main {

    static int[] qs(int[] nn, int b, int e) {
        if(e - b <= 1)
            return nn;
        int p = nn[b];
        int ll = b + 1;
        System.out.print(b + ": ");
        System.out.print(nn[b]);
        for(int i = b + 1; i < e; i++) {
            System.out.print(", " + nn[i]);
            if(nn[i] <= p)
                ll++;
        }
        System.out.println("");
        int t = 0;
        for(int i = b + 1, j = ll; i < ll; i++)
            if(nn[i] > p) {
                while(nn[j] > p) j++;
                t = nn[i];
                nn[i] = nn[j];
                nn[j] = t;
            }
        qs(nn, b + 1, ll);
        qs(nn, ll, e);
        for(int k = b + 1; k < ll; k++)
            nn[k-1] = nn[k];
        nn[ll - 1] = p;
        System.out.print(b + ": ");
        System.out.print(nn[b]);
        for(int i = b + 1; i < e; i++)
            System.out.print(", " + nn[i]);
        System.out.println("");
        return nn;
    }

    public static void main(String[] args) {
        int nn[] = {1, 3, 4, 2, 5, 8, 9, 10, 3 };
        System.out.println(Arrays.toString(nn) + ": " + Arrays.toString(qs(nn, 0, nn.length)));
    }
}
