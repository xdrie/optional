module tests.match;

import optional;

@("Should work with qualified optionals")
@safe @nogc unittest {
    import std.meta: AliasSeq;
    foreach (T; AliasSeq!(Optional!int, const Optional!int, immutable Optional!int)) {
        T a = some(3);
        auto r = a.match!(
            (int a) => "yes",
            () => "no",
        );
        assert(r == "yes");
    }
}

@("shoudl work with void return")
unittest {
    int i = 0;
    int j = 0;

    auto yes = some(1);
    auto no = no!int;

    void fun(int x) { j = x; }

    yes.match!(
        (int a) => i = a,
        () => fun(3),
    );

    assert(i == 1);
    assert(j == 0);

    no.match!(
        (int a) => i = a + 1,
        () => fun(3),
    );

    assert(i == 1);
    assert(j == 3);


}
