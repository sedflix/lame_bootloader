
import java.io.*;
import java.util.*;

public class lab {
	public static void main(String[] args) throws IOException {
		
		Reader.init(System.in);

		int T = Reader.nextInt();

		for (int i = 0; i < T; i++ ) {

            ArrayList<Slot> list = new ArrayList<>();
			
			int N = Reader.nextInt();
            
            for (int j = 0; j < N; j++ ) {
				list.add(new Slot(Reader.nextInt(), Reader.nextInt()));
            }
            
            Collections.sort(list);

            int maxEndTime = -1;
            int counter = 0;
            for (Slot oSlot : list) {
                if(oSlot.startTime >= maxEndTime) {
                    counter++;
                    maxEndTime = oSlot.endTime;
                }
            }

            System.out.println(counter);

		}
	}

    private static class Slot implements Comparable{
        int startTime;
        int endTime;

        Slot(int a, int b) {
            startTime = a;
            endTime = b;
        }
        @Override
        public int compareTo(Object o) {
            return -(((Slot)o).endTime - this.endTime);
        }
    }
}

class Reader {
    static BufferedReader reader;
    static StringTokenizer tokenizer;

    /** call this method to initialize reader for InputStream */
    static void init(InputStream input) {
        reader = new BufferedReader(
                     new InputStreamReader(input) );
        tokenizer = new StringTokenizer("");
    }

    /** get next word */
    static String next() throws IOException {
        while ( ! tokenizer.hasMoreTokens() ) {
            //TODO add check for eof if necessary
            tokenizer = new StringTokenizer(
                   reader.readLine() );
        }
        return tokenizer.nextToken();
    }

    static int nextInt() throws IOException {
        return Integer.parseInt( next() );
    }

    static double nextDouble() throws IOException {
        return Double.parseDouble( next() );
    }

    static long nextLong() throws IOException {
        return Long.parseLong( next() );
    }
}