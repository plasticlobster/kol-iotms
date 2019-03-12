notify plasticlobster;
since r10000;

string reverse(string string_in) {
   int len = length(string_in);
   buffer out;
   for a from (len - 1) downto 0 {
      out = append(out, char_at(string_in, a));
   }
   return to_string(out);
}

string nwc(int num_in) {
   buffer out;
   string neg = "";
   if (num_in < 0) {
      neg = "-";
      num_in = (-1) * num_in;
   }
   
   string rev = reverse(to_string(num_in));
   int len = length(rev); 
   for a from 0 upto (len - 1) {
      out = append(out, char_at(rev, a));
      if ((((a + 1) % 3) == 0) && (a != (len - 1))){
         out = append(out, ",");
      }
   }
   return neg+reverse(to_string(out));
}

void printSectionHeader(string which_section) {
   print("Items Currently in "+which_section+": ", "blue");
}

void printSectionFooter(int num_items) {
   string iar = '';
   if (num_items == 37) {
      iar = " (in a row?!?)";
   }
   if (num_items > 0) {
      print(num_items + " Items Found"+iar, "green");
   } else {
      print("No tradable Mr. Store/Ultra Rare Items Found", "red");
   }
}

void printItemCount(item it, int num_items) {
   if (num_items > 0) {
      boolean plural = true;
      int mall_price = -1;
      boolean show_prices = get_property("PLIotMShowPrices").to_boolean();
      if (show_prices) {
         if (get_property("PLIotMSearchMall").to_boolean()) {
            mall_price = mall_price(it);
         } else {
            mall_price = historical_price(it);
         }
      }
      string out = "- ("+num_items+") ";
      if (num_items == 1) {
         out = out + it;
      } else {
         out = out + to_plural(it);
      }
      if (show_prices) {
         out = out + " (" + nwc(mall_price) + " Meat)";
      }
      print(out);
   }
}

int search_inventory(item[int] iotms) {
   printSectionHeader("Inventory");
   int total = 0;
   foreach a in iotms {
      int num_items = item_amount(iotms[a]) + equipped_amount(iotms[a]);
      total = total + num_items;
      printItemCount(iotms[a], num_items);
   }
   printSectionFooter(total);
   return total;
}

int search_storage(item[int] iotms) {
   printSectionHeader("Hagnk's");
   int total = 0;
   foreach a in iotms {
      int num_items = storage_amount(iotms[a]);
      total = total + num_items;
      printItemCount(iotms[a], num_items);
   }
   printSectionFooter(total);
   return total;
}

int search_closet(item[int] iotms) {
   printSectionHeader("your Closet");
   int total = 0;
   foreach a in iotms {
      int num_items = closet_amount(iotms[a]);
      total = total + num_items;
      printItemCount(iotms[a], num_items);
   }
   printSectionFooter(total);
   return total;
}

int search_shop(item[int] iotms) {
   printSectionHeader("your Mall Store");
   int total = 0;
   foreach a in iotms {
      int num_items = shop_amount(iotms[a]);
      total = total + num_items;
      printItemCount(iotms[a], num_items);
   }
   printSectionFooter(total);
   return total;
}

int search_display(item[int] iotms) {
   printSectionHeader("your Display Case");
   int total = 0;
   foreach a in iotms {
      int num_items = display_amount(iotms[a]);
      total = total + num_items;
      printItemCount(iotms[a], num_items);
   }
   printSectionFooter(total);
   return total;
}

item workshed_item() {
   int[item] campground = get_campground();
   foreach a in campground {
      if (a == $item[Little Geneticist DNA-Splicing Lab]) return a;
      if (a == $item[portable Mayo Clinic]) return a;
   }

   return $item[none];
}

int search_workshed(item[int] iotms) {
   printSectionHeader("Your Workshed");
   int num_items = 0;
   foreach a in iotms {
      if ((workshed_item() == iotms[a]) && (iotms[a] != $item[none])){
         printItemCount(iotms[a], 1);
         num_items = 1;
      }
   }
   printSectionFooter(num_items);
   return num_items;
}

void printTotal(int num_items) {
   print("-----------------------------------------");
   string iar = "";
   if (num_items == 37) {
      iar = " (in a row?!?)";
   }
   print("Total Mr. Store Items/Ultra-Rares Found: "+num_items+iar);
   print("-----------------------------------------");
}

void main() {
   item[int] iotms;
   file_to_map('https://raw.githubusercontent.com/plasticlobster/kol-iotms/master/data/PL-iotms.txt', iotms);

   string[int] iotms_txt;
   file_to_map('https://raw.githubusercontent.com/plasticlobster/kol-iotms/master/data/PL-iotms.txt', iotms_txt);

   foreach a in iotms {
      if (iotms[a] == $item[none]) {
         print("Warning: Item "+iotms_txt[a]+" Not identified by KoLMafia. If this is a new item, you may need a new version of KoLMafia to support it. If this is a valid item recognized by KoLMafia, please KMail PlasticLobster to fix this issue.", "red");
         wait(5);
      }
   }
   int total = 0;
   print("-----------------------------------------");
   print("This script will search your inventory, closet, Hagnk's, workshed, and display case for tradable Mr. Store");
   print("Items as well as Ultra Rares");
   print("Because nobody likes losing their valuable stuff.");
   print("-----------------------------------------");
   total = total + search_inventory(iotms);
   total = total + search_storage(iotms);
   total = total + search_closet(iotms);
   total = total + search_shop(iotms);
   total = total + search_display(iotms);
   total = total + search_workshed(iotms);
   printTotal(total);
   if (total == 0) {
      print("A poor adventurer is you.");
   }
}
