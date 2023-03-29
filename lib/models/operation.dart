import 'package:conduit/conduit.dart';
import 'user.dart';

class Operations extends ManagedObject<_Operation> implements _Operation {}

class _Operation{

  @primaryKey
  int? operationID;

  @Column(unique: false, indexed: true)
  String? operationName;

  @Column(unique: false, indexed: true)
  String? operationDescription;

  @Column(unique: false, indexed: true)
  String? operationType;

  @Column(unique: false, indexed: true)
  String? operationDate;

  @Column(unique: false, indexed: true)
  String? operationAmount;

  @Relate(#operationsList, isRequired: true, onDelete: DeleteRule.cascade)
  User? user;
}