notify plasticlobster;
since r10000;

record inventories {
   int inventory;
   int storage;
   int display;
   int closet;
   int store;
   int workbench;
};

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
      print("No tradeable Mr. Store/Ultra Rare Items Found", "red");
   }
}

void printItemCount(item it, int num_items) {
   if (num_items > 0) {
      boolean plural = true;
      if (num_items == 1) {
         plural = false;
         print("- ("+num_items+") "+it);
      } else {
         print("- ("+num_items+") "+to_plural(it));
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
   string workshed_page = visit_url("campground.php?action=workshed");
   matcher match_dna = create_matcher("Little Geneticist DNA-Splicing Lab", workshed_page);
   matcher match_mayo = create_matcher("Mayo Clinic", workshed_page);

   #These are the only two non-BOE workshed IOTM's
   if (match_dna.find()) {
      return $item[Little Geneticist DNA-Splicing Lab];
   }
   if (match_mayo.find()) {
      return $item[portable Mayo Clinic];
   }

   return $item[none];
}

int search_workshed(item[int] iotms) {
   printSectionHeader("Your Workshed");
   print("This will take a while.", "red");
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

void main(boolean skip_workshed) {
   item[int] iotms;
   file_to_map('https://raw.githubusercontent.com/plasticlobster/kol-iotms/master/data/PL-iotms.txt', iotms);

   foreach a in iotms {
      if (iotms[a] == $item[none]) abort("Error: Invalid Item Found in Data File. KMail PlasticLobster to fix.");
   }
   int total = 0;
   print("-----------------------------------------");
   print("This script will search your inventory, closet, Hagnk's, workshed, and display case for tradeable Mr. Store");
   print("Items as well as Ultra Rares");
   print("Because nobody likes losing their valuable stuff.");
   print("-----------------------------------------");
   total = total + search_inventory(iotms);
   total = total + search_storage(iotms);
   total = total + search_closet(iotms);
   total = total + search_shop(iotms);
   total = total + search_display(iotms);
   if (!skip_workshed) {
      total = total + search_workshed(iotms);
   }
   printTotal(total);
   if (total == 0) {
      print("A poor adventurer is you.");
   }
}
