import 'package:equatable/equatable.dart';

class MenuData extends Equatable {
  final String image;
  final String title;

  const MenuData(this.image, this.title);

  @override
  List<Object?> get props => [image, title];
}
