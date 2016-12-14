/*
  You are given several shopping carts.  Find the items that are
  most popular. An item is most popular when the item is
  selected by most customers.

  Each shopping cart is given as a multiset.
 */

/*

  Consider following shopping carts.

  sc1
  1: 1
  2: 1
  3: 2

  sc2
  2: 1
  3: 1

  sc3
  1: 1
  3: 1

  The following table shows the items that each customer selected.

    | sc1 | sc2 | sc3 | sum
  1 |  *  |     |  *  |  2
  2 |  *  |  *  |     |  2
  3 |  *  |  *  |  *  |  3

  Thus, there is only one most popular item, item 3.

 */

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

public class main {
    public static void main(String argv[]) {

        List<Map<Integer, Object>> carts = new ArrayList<Map<Integer, Object>>();

        Map<Integer, Object> sc1 = new HashMap<Integer, Object>();
        sc1.put(1, 1);
        sc1.put(2, 1);
        sc1.put(3, 2);
        carts.add(sc1);

        Map<Integer, Object> sc2 = new HashMap<Integer, Object>();
        sc2.put(2, 1);
        sc2.put(3, 1);
        carts.add(sc2);

        Map<Integer, Object> sc3 = new HashMap<Integer, Object>();
        sc3.put(1, 1);
        sc3.put(3, 1);
        carts.add(sc3);

        Map<Integer, Integer> popularity = new HashMap<Integer, Integer>();
        for(Map<Integer, Object> sc : carts) {
            for(Map.Entry<Integer, Object> e : sc.entrySet()) {
                if(popularity.get(e.getKey()) == null) {
                    popularity.put(e.getKey(), 1);
                } else {
                    Integer p = popularity.get(e.getKey());
                    popularity.put(e.getKey(), p + 1);
                }
            }
        }
        
        Integer mk = null;
        Integer max = null;
        for(Map.Entry<Integer, Integer> e : popularity.entrySet()) {
            if(max == null || max < e.getValue()) {
                mk = e.getKey();
                max = e.getValue();
            }
        }
        System.out.println("most popular product is " + mk);
    }
}
