with Core_C;
pragma Elaborate_All (Core_C);

package body Runtime_Init is

   procedure adainit;
   pragma Import (C, adainit, "adainit");

   procedure Init is
   begin
      -- Initialize Ada runtime
      adainit;

      -- Force elaboration chain:
      -- Core_C → Core
      null;
   end Init;

end Runtime_Init;
