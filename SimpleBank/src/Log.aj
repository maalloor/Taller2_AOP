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
    	System.out.println(tipoTransaccion);
    	System.out.println(strDate);
    	generateFile();
    }
    pointcut successDrawal() : call(* moneyWith*(..) );
    after() : successDrawal(){
    tipoTransaccion = "*** Retiro Realizado ***";
    	System.out.println(tipoTransaccion);
    	System.out.println(strDate);
    	generateFile();
    }
    public void generateFile()
    {
    	try {
            FileWriter fw = new FileWriter(file);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(tipoTransaccion+"\n");
            bw.write(strDate+"\n");
            bw.write("-----------------------\n");
            bw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
