void main(){
    double i = 0.0;
    double finale = 100000000;
    double step = finale / 10;

    while (i < finale) {
        i = i+1;
        if (i % step == 1) {
            print("\r ${i/finale*100}%");
        }
    }
    print("\n ${i.toString()} end\n");
}


