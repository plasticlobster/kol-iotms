notify plasticlobster;
since r10000;

void main() {
   item[int] iotms;
   file_to_map('PL-iotms.txt', iotms);
   int total = 0;
   foreach a in iotms {
      int num_items = item_amount(iotms[a]);
      total = total + num_items;
      if (num_items > 0) {
         boolean plural = true;
         if (num_items == 1) {
            plural = false;
            print("You have "+num_items+" "+iotms[a]+" in your inventory.");
         } else {
            print("You have "+num_items+" "+to_plural(iotms[a])+" in your inventory.");
         }
      }

      num_items = storage_amount(iotms[a]);
      total = total + num_items;
      if (num_items > 0) {
         boolean plural = true;
         if (num_items == 1) {
            plural = false;
            print("You have "+num_items+" "+iotms[a]+" in Hagnk's.");
         } else {
            print("You have "+num_items+" "+to_plural(iotms[a])+" in Hagnk's.");
         }
      }

      num_items = closet_amount(iotms[a]);
      total = total + num_items;
      if (num_items > 0) {
         boolean plural = true;
         if (num_items == 1) {
            plural = false;
            print("You have "+num_items+" "+iotms[a]+" in your closet.");
         } else {
            print("You have "+num_items+" "+to_plural(iotms[a])+" in your closet.");
         }
      }

      num_items = shop_amount(iotms[a]);
      total = total + num_items;
      if (num_items > 0) {
         boolean plural = true;
         if (num_items == 1) {
            plural = false;
            print("You have "+num_items+" "+iotms[a]+" in your mall store.");
         } else {
            print("You have "+num_items+" "+to_plural(iotms[a])+" in your mall store.");
         }
      }

      num_items = display_amount(iotms[a]);
      total = total + num_items;
      if (num_items > 0) {
         boolean plural = true;
         if (num_items == 1) {
            plural = false;
            print("You have "+num_items+" "+iotms[a]+" in your display case.");
         } else {
            print("You have "+num_items+" "+to_plural(iotms[a])+" in your display case.");
         }
      }
   }
   print("Found "+total+" IotM's in Total");
}
