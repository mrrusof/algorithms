#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#define btos(b) (b ? "true" : "false")

// 127.0.0.1
// 0123456789
// b  i
//     bi
//       bi
//         bi
bool isip4(char *ip) {
  int begin = 0;
  int i = 0;
  int octet[] = {-1, -1, -1, -1};
  int octet_n = 0;
  char buff[4];
  while(ip[i] != 0) {
    if(ip[i] == '.') { /// split
      // assert(octet_n < 4)
      if(i-begin < 1 || i-begin > 3) {
	//	printf("LOG: octet length\n");
	return false;
      }
      buff[3] = '\0';
      for(int j = 0; j < i-begin; j++) {
	if(ip[j+begin] != '0' &&
	   ip[j+begin] != '1' &&
	   ip[j+begin] != '2' &&
	   ip[j+begin] != '3' &&
	   ip[j+begin] != '4' &&
	   ip[j+begin] != '5' &&
	   ip[j+begin] != '6' &&
	   ip[j+begin] != '7' &&
	   ip[j+begin] != '8' &&
	   ip[j+begin] != '9') {
	  //	  printf("LOG: not a digit (%d)\n", ip[j+begin]);
	  return false;
	}
	buff[j] = ip[j+begin];
	//	printf("buff[%d] = %c\n", j, buff[j]);
      }
      octet[octet_n] = atoi(buff);
      octet_n++;
      begin = i+1;
    }
    i++;
  }

  if(i-begin < 1 || i-begin > 3) {
    //    printf("LOG: octet length\n");
    return false;
  }
  buff[3] = '\0';
  for(int j = 0; j < i-begin; j++) {
    if(ip[j+begin] != '0' &&
       ip[j+begin] != '1' &&
       ip[j+begin] != '2' &&
       ip[j+begin] != '3' &&
       ip[j+begin] != '4' &&
       ip[j+begin] != '5' &&
       ip[j+begin] != '6' &&
       ip[j+begin] != '7' &&
       ip[j+begin] != '8' &&
       ip[j+begin] != '9') {
      //      printf("LOG: not a digit (%d)\n", ip[j+begin]);
      return false;
    }
    buff[j] = ip[j+begin];
    //    printf("buff[%d] = %c\n", j, buff[j]);
  }
  octet[octet_n] = atoi(buff);
  //  printf("octet[%d] = %d\n", octet_n, octet[octet_n]);


  for(int j = 0; j < 4; j++)
    if(octet[j] < 0 || octet[j] > 255) {
      //      printf("LOG: octet range (%d)\n", octet[j]);
      return false;
    }

  return true;
}

int main() {
  //  printf("begin\n");
  printf("isip4(\"%s\") = %s\n", "127.0.0.1", btos(isip4("127.0.0.1")));
  printf("isip4(\"%s\") = %s\n", "12a.0.0.1", btos(isip4("12a.0.0.1")));
  printf("isip4(\"%s\") = %s\n", "basura", btos(isip4("basura")));
  printf("isip4(\"%s\") = %s\n", "201.141.223.137", btos(isip4("201.141.223.137")));
  printf("isip4(\"%s\") = %s\n", "", btos(isip4("")));
  printf("isip4(\"%s\") = %s\n", "193.168.0.1213", btos(isip4("193.168.0.1213")));
  printf("isip4(\"%s\") = %s\n", "201.141.2023.137", btos(isip4("201.141.2023.137")));
  printf("isip4(\"%s\") = %s\n", "0.-1.0.0", btos(isip4("0.-1.0.0")));
  printf("isip4(\"%s\") = %s\n", "a.b.c.d", btos(isip4("a.b.c.d")));
  printf("isip4(\"%s\") = %s\n", "0.0", btos(isip4("0.0")));
  printf("isip4(\"%s\") = %s\n", "0.256.0.0", btos(isip4("0.256.0.0")));
  printf("isip4(\"%s\") = %s\n", "0.0.0.0", btos(isip4("0.0.0.0")));
  return 0;
}
