import java.io.File;
import java.util.Calendar;

public aspect Log {

    File file = new File("log.txt");
    String line="";
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* money*(..) );
    after() : success() {
    	System.out.println("**** Transaction Complete ****");
    	
    }
}
