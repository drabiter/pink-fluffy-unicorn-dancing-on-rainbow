public class PinkFluffyUnicornDancingOnRainbow {

    private final long RATE = 100;
    private final String[] OPEN_UNICORN = new String[]{
          "          /| ",
          " ~～～～~/ | ",
          "|       O  O ",
          "|         ∇ |",
          " ~~~~∪∪~~~∪∪ "
        };
    private final String[] CLOSE_UNICORN = new String[]{
          "          /| ",
          " ～～～～/ | ",
          "|       ⌒  ⌒ ",
          "|         ∇ |",
          " ~~∪∪~~~∪∪~~ "
        };
    private int[] COLORS = new int[]{31, 33, 32, 36, 35, 34};
    private final int UNICORN_WIDTH = OPEN_UNICORN[0].length();

    private int termWidth = 64;
    private int unicornOffset = (termWidth - UNICORN_WIDTH) / 2;

    private long counter = 0;

    public static void main(String[] args) throws Exception {
        PinkFluffyUnicornDancingOnRainbow unicorn = new PinkFluffyUnicornDancingOnRainbow();
        unicorn.run();
    }

    public void run() throws Exception {
        while (true) {
            clear();

            draw(counter);
            counter++;

            println("Press Ctrl-C to exit...");

            Thread.sleep(RATE);
        }
    }

    private void print(Object _) {
        if (_ == null) return;
        System.out.print(_);
    }

    private void println(Object _) {
        if (_ == null) return;
        System.out.println(_);
    }

    private void clear() {
        print("\033c");
    }

    private void renderSpace(int number) {
        for (int i = 0; i < number; i++) {
            print(" ");
        }
    }

    private String pinkify(String _) {
        return "\033[96m" + _ + "\033[0m";
    }

    private void renderUnicorn(String[] unicorns) {
        for (int i = 0; i < unicorns.length; i++) {
            renderSpace(unicornOffset);

            println(pinkify(unicorns[i]));
        }
    }

    private String rainbowify(String str, int index) {
        int color = COLORS[index];
        return "\033[" + color + "m" + str + "\033[0m";
    }

    private void renderRainbow() {
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < termWidth; j++) {
                long _ = counter + j;
                if (_ % 2 == 0) {
                    print(rainbowify("-", i));
                } else {
                    print(rainbowify("_", i));
                }
            }
            println("");
        }
    }

    private void draw(long counter) {
        String[] _unicorn = (counter % 10 > 5)? OPEN_UNICORN : CLOSE_UNICORN;
        renderUnicorn(_unicorn);

        renderRainbow();
    }
}
