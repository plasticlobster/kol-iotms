notify plasticlobster;
since r10000;

string nwc(int num) {
   float fnum = to_float(num);
   if (num > 1000) {
      int nextnum = truncate(fnum / 1000.0);
      int without_dec = nextnum * 1000;
      int dec_part = (num - without_dec);
      string addl = '';
      if (dec_part < 100) {
         addl = '0';
      }
      if (dec_part == 0) {
         addl = '00';
      }
      return nwc(nextnum)+","+addl+to_string(dec_part);
   } else {
      return to_string(num);
   }
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
      if (num_items == 1) {
         plural = false;
         print("- ("+num_items+") "+it+" ("+nwc(historical_price(it))+" Meat)");
      } else {
         print("- ("+num_items+") "+to_plural(it)+" ("+nwc(historical_price(it))+" Meat)");
      }
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
      if (workshed_item() == iotms[a]) {
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
