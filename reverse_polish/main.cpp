#include <iostream>
#include <string>
#include <sstream>
#include <stack>

using namespace std;

struct OptionInt {
    bool result;
    int value;
};

bool isDigit(string& s) {
    for (int i = 0; i < s.size(); i++) {
        if (s[i] < '0' || s[i] > '9') {
            return false;
        }
    }

    return true;
}

OptionInt evaluate(string& line) {
    string s;
    stringstream ss(line);
    stack<int> st;

    while (! ss.eof()) {
        ss >> s;

        if (s == "+" || s == "-" || s == "*" || s == "/" || s == "%") {
            if (st.size() < 2) {
                cerr << "parse error" << endl;
                return OptionInt{ false, 0 };
            }

            int a = st.top();
            st.pop();
            int b = st.top();
            st.pop();

            if (s == "+") {
                st.push(b + a);
            } else if (s == "-") {
                st.push(b - a);
            } else if (s == "*") {
                st.push(b * a);
            } else if (s == "/") {
                if (a == 0) {
                    cerr << "zero division" << endl;
                    return OptionInt{ false, 0 };
                }
                st.push(b / a);
            } else if (s == "%") {
                if (a == 0) {
                    cerr << "zero division" << endl;
                    return OptionInt{ false, 0 };
                }
                st.push(b % a);
            }
        } else if (isDigit(s)) {
            st.push(stoi(s));
        } else {
            cerr << "illegal argument " << s << endl;
            return OptionInt{false, 0 };
        }
    }

    if (st.size() != 1) {
        cerr << "parse error" << endl;
        return OptionInt{ false, 0 };
    }

    return OptionInt{ true, st.top() };
}

int main() {
    string line;

    getline(cin, line);
    OptionInt opt_value = evaluate(line);

    if (opt_value.result) {
        cout << opt_value.value << endl;
    }

    return 0;
}
