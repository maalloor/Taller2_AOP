import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public aspect Log {

    File file = new File("log.txt");
    Date cal = Calendar.getInstance().getTime();
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    String strDate = dateFormat.format(cal.getTime());  
    String tipoTransaccion;
    
    pointcut successTransaction() : call(* moneyMake*(..) );
    after() : successTransaction() {
    	tipoTransaccion = "*** Transaccion Realizada ***";
    	generateFileAndConsole();
    }
    pointcut successDrawal() : call(* moneyWith*(..) );
    after() : successDrawal(){
    	tipoTransaccion = "*** Retiro Realizado ***";
    	generateFileAndConsole();
    }
    public void generateFileAndConsole()
    {
    	System.out.println(tipoTransaccion);
    	System.out.println(strDate);
    	try (BufferedWriter bw = new BufferedWriter(new FileWriter(file.getAbsoluteFile(),true)))
    	{
    		bw.write(tipoTransaccion+"\n");
            bw.write(strDate+"\n");
            bw.write("-----------------------\n");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
