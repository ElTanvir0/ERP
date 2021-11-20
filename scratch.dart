void main() {
  var groupedList = <String, List<MyClass>>{};
  var listOfObjects = <MyClass>[
    MyClass('Europe', 'France'),
    MyClass('Europe', 'Germany'),
    MyClass('Europe', 'Italy'),
    MyClass('North America', 'USA'),
    MyClass('Asia', 'Japan'),
    MyClass('Asia', 'China'),
  ];

  for (var item in listOfObjects) {
    groupedList.putIfAbsent(item.someProperty, () => <MyClass>[]).add(item);
  }

  print(groupedList);
}

class MyClass {
  String someProperty;
  String someValue;

  MyClass(this.someProperty, this.someValue);

  @override
  String toString() => '$someProperty->$someValue';
}
