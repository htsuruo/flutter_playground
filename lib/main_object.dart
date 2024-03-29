import 'logger.dart';

// 【Dart】Objectクラスの基本
// ref. https://zenn.dev/iwaku/articles/2020-12-18-iwaku

// Null以外の全てのDartクラスはすべてObjectでできており
// Objectクラスは`toString()`, `==`, `hashCode`が備わっている

void main() {
  final hoge = Hoge('hoge');
  final hoge2 = hoge;
  logger
    ..fine('hoge.toString(): $hoge')
    ..fine('hoge hashcode: ${hoge.hashCode}')
    // 同一インスタンスであればhashcodeが一緒
    ..fine('hoge2 hashcode: ${hoge2.hashCode}')
    // 同一インスタンスであれば当然同じObjectとして扱われる
    ..fine('hoge == hoge2: ${hoge == hoge2}');

  final hoge3 = Hoge('hoge');
  // 同じ`name`でも通常インスタンスが異なれば異なるhashcodeとなる
  logger
    ..fine('hoge3 hashcode: ${hoge3.hashCode}')
    // ignore: cascade_invocations
    ..fine('hoge == hoge3: ${hoge == hoge3}');

  // 同一`name`を同じObjectとして扱い場合はhashcodeの算出を弄れば良い

  final foo = Hoge('foo');
  logger
    ..fine('foo.toString(): $foo')
    // 通常Objectはインスタンスごとにhashcodeが代わる. これは真っ当な挙動
    ..fine('foo hashcode: ${foo.hashCode}')
    // 当然別インスタンスかつ`name`が異なれば別のObjectを意図しているはずなので`false`となる
    ..fine('hoge == foo: ${hoge == foo}');
}

class Hoge {
  Hoge(this.name);

  final String name;

  // `name`が同じインスタンスは同一Objectとしてみなしたい場合は
  // `==`を弄れば良い
  @override
  bool operator ==(Object other) {
    // 同一インスタンスか否かを早期判定
    if (identical(this, other)) {
      return true;
    }
    if (other is Hoge) {
      // 同一`name`の場合は同一Objectとしてみなす
      return runtimeType == other.runtimeType && name == other.name;
    }
    return false;
  }

  // @override
  // こうすると`name`フィールドのhashcodeで判定されるので同一`name`つまり
  // 同一文字列であれば同じhashcodeが帰るようになる
  // ただし、同じObjectとして扱うためには`==`の変更も必要
  @override
  int get hashCode => name.hashCode;

  // 他のフィールドを持っていた時には下記の書き方となる
  // ちなみに`^`はXOR（排他的論理和）で同じhashCodeだとゼロとなる
  // int get hashCode => name.hashCode ^ name.age;

  @override
  String toString() {
    // return super.toString();
    // `toString`の出力を自由に変更できる -> `hoge`
    return name;
  }
}
