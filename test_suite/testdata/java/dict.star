# creation

foo = {'a': 1, 'b': [1, 2]}
bar = dict(a=1, b=[1, 2])
baz = dict({'a': 1, 'b': [1, 2]})

assert_eq(foo, bar)
assert_eq(foo, baz)

# get/setdefault

assert_eq(foo.get('a'), 1)
assert_eq(bar.get('b'), [1, 2])
assert_eq(baz.get('c'), None)
assert_eq(baz.setdefault('c', 15), 15)
assert_eq(baz.setdefault('c'), 15)
assert_eq(baz.setdefault('c', 20), 15)
assert_eq(baz.setdefault('d'), None)

# items

assert_eq(foo.items(), [('a', 1), ('b', [1, 2])])

# keys

assert_eq(bar.keys(), ['a', 'b'])

# values

assert_eq(baz.values(), [1, [1, 2], 15, None])

# pop/popitem

assert_eq(baz.pop('d'), None)
assert_eq(foo.pop('a'), 1)
assert_eq(bar.popitem(), ('a', 1))
assert_eq(foo, bar)
assert_eq(foo.pop('a', 0), 0)
assert_eq(foo.popitem(), ('b', [1, 2]))

---
dict().popitem() ### empty
---
dict(a=2).pop('z') ### key
---

# update

foo = dict()
baz = dict(a=1, b=[1, 2])
bar = dict(b=[1, 2])

foo.update(baz)
bar.update(a=1)
baz.update({'c': 3})
foo.update([('c', 3)])
bar['c'] = 3
quz = dict()
quz.update(bar.items())

assert_eq(foo, bar)
assert_eq(foo, baz)
assert_eq(foo, quz)
---

d = {"b": 0}
d.update({"a": 1}, b = 2)
d.update({"c": 0}, c = 3, d = 4)
d.update([("e", 5)])

# _inconsistency_: rust dict.update doesn't accept tuples
# d.update((["f", 0],), f = 6)
# expected = {"a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6}

expected = {"a": 1, "b": 2, "c": 3, "d": 4, "e": 5}
assert_eq(d, expected)


# creation with repeated keys

d1 = dict([('a', 1)], a=2)
d2 = dict({'a': 1}, a=2)
d3 = dict([('a', 1), ('a', 2)])

assert_eq(d1['a'], 2)
assert_eq(d1, d2)
assert_eq(d1, d3)
