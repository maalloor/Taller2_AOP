


public aspect Logger {

    pointcut success() : call(* create*(..) );
    after() : success() { 
    	System.out.println("**** Usuario creado ****");
    }
}