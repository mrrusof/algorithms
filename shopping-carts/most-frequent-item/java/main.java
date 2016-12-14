/*
  You are given several shopping carts.  Find the items that are most
  frequently bought.  The number of times an item is bought is given
  by the count of the item accross all carts.
 */

/*

  Consider the following shopping carts.

  sc1
  1: 1
  2: 2
  3: 2

  sc2
  2: 2
  3: 1

  sc3
  1: 1
  3: 1

  The following table shows the frequency of each item.

    | sc1 | sc2 | sc3 | sum
  1 |  1  |     |  1  |  2
  2 |  2  |  2  |     |  4
  3 |  2  |  1  |  1  |  4

  Thus, the most frequently bought items are 2 and 3.

 */

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

public class main {

    public static void main(String arg[]) {
        List<Map<Integer, Integer>> carts = new ArrayList<Map<Integer, Integer>>();

        Map<Integer, Integer> sc1 = new HashMap<Integer, Integer>();
        sc1.put(1, 1);
        sc1.put(2, 2);
        sc1.put(3, 2);
        carts.add(sc1);

        Map<Integer, Integer> sc2 = new HashMap<Integer, Integer>();
        sc2.put(2, 2);
        sc2.put(3, 1);
        carts.add(sc2);

        Map<Integer, Integer> sc3 = new HashMap<Integer, Integer>();
        sc3.put(1, 1);
        sc3.put(3, 1);
        carts.add(sc3);

        Map<Integer, Integer> count = new HashMap<Integer, Integer>();

        for(Map<Integer, Integer> sc : carts) {
            for(Map.Entry<Integer, Integer> e : sc.entrySet()) {
                if(count.get(e.getKey()) == null) {
                    count.put(e.getKey(), 1);
                } else {
                    Integer cc = count.get(e.getKey());
                    count.put(e.getKey(), cc + e.getValue());
                }
            }
        }

        List<Integer> items = new ArrayList<Integer>();
        Integer max = null;
        for(Map.Entry<Integer, Integer> e : count.entrySet()) {
            if(max == null || max < e.getValue()) {
                items.clear();
                items.add(e.getKey());
                max = e.getValue();
            } else if(max == e.getValue()) {
                items.add(e.getKey());
            }
        }

        for(Integer item : items) {
            System.out.println(item);
        }
   }

}