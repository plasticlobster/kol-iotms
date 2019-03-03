void main() {
   item[int] iotms;
   file_to_map('PL-iotms.txt', iotms);
   foreach a in iotms {
      int num_items = item_amount(iotms[a]);
      if (num_items > 0) {
         boolean plural = true;
         if (num_items == 1) {
            plural = false;
            print("You have "+num_items+" "+iotms[a]);
         } else {
            print("You have "+num_items+" "+to_plural(iotms[a]));
         }
      }
   }
}
