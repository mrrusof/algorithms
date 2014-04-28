using System.Collections.Generic;
using System.Linq;
using System;

class Program
{
  static List<int> quicksort(List<int> l)
  {
    if (l.Count() <= 1) return l;
    List<int> sorted = new List<int>(l.Count());
    sorted.AddRange(quicksort(l.GetRange(1, l.Count()-1).FindAll(n => n <= l[0])));
    sorted.Add(l[0]);
    sorted.AddRange(quicksort(l.GetRange(1, l.Count()-1).FindAll(n => n > l[0])));
    return sorted;
  }
  
  static void Main()
  {
    Console.WriteLine("Input a sequence of numbers separated by comma: ");
    string raw = Console.ReadLine();
    List<string> nums = raw.Split(new Char[]{','}).ToList();
    if ( ! nums.TrueForAll(s => { int n; return int.TryParse(s, out n); }))
    {
      Console.WriteLine("ERROR: input is not a sequence of numbers.\n");
      Environment.Exit(1);
    }
    List<int> sorted = quicksort(nums.Select(s => Convert.ToInt32(s)).ToList());
    sorted.ForEach(n => Console.Write(n + ", "));
    Console.WriteLine();
  }
}
