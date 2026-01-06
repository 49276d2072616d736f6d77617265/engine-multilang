with Interfaces.C;

package Runtime_Init is
   procedure Init
     with Export, Convention => C, External_Name => "ada_runtime_init";
end Runtime_Init;
