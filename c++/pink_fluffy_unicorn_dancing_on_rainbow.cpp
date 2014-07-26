#include <iostream>
#include <string>
#include <sys/ioctl.h>
#include <unistd.h>

using namespace std;

const long kRate = 100000;
const string kOpenUnicorn [5] = {
      "          /| ",
      " ~～～～~/ | ",
      "|       O  O ",
      "|         ∇ |",
      " ~~~~∪∪~~~∪∪ "
    };
const string kCloseUnicorn [5] = {
      "          /| ",
      " ～～～～/ | ",
      "|       ⌒  ⌒ ",
      "|         ∇ |",
      " ~~∪∪~~~∪∪~~ "
    };
const int kColors [6] = {31, 33, 32, 36, 35, 34};
const int kUnicornWidth = kOpenUnicorn[0].length();
const int kUnicornHeight = 5;

int term_width;
int unicorn_offset;
unsigned int counter;

void clear() {
  cout << "\033c";
}

void println(string _) {
  cout << _;
  cout << "\n";
}

void renderSpace(int _offset) {
  for (int i = 0; i < _offset; i++) {
    cout << " ";
  }
}

string pinkify(string _) {
  return "\033[96m" + _ + "\033[0m";
}

void renderUnicorn(const string _unicorns[]) {
  for (int i = 0; i < kUnicornHeight; i++) {
    renderSpace(unicorn_offset);

    println(pinkify(_unicorns[i]));
  }
}

string rainbowify(string str, int index) {
  int color = kColors[index];
  return "\033[" + to_string(color) + "m" + str + "\033[0m";
}

void renderRainbow(int _counter) {
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < term_width; j++) {
      long _ = _counter + j;
      if (_ % 2 == 0) {
        cout << rainbowify("-", i);
      } else {
        cout << rainbowify("_", i);
      }
    }
    println("");
  }
}

void draw(int _counter) {
  renderUnicorn((_counter % 10 > 5)? kOpenUnicorn : kCloseUnicorn);

  renderRainbow(_counter);
}

int main() {
  struct winsize w;
  ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);

  term_width = w.ws_col;
  unicorn_offset = (term_width - kUnicornWidth) / 2;
  counter = 0;

  while (true) {
    clear();

    draw(counter);
    counter++;

    println("Press Ctrl-C to exit...");

    usleep(kRate);
  }
  return 0;
}
