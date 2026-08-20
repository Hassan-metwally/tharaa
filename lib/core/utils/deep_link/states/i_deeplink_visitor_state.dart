import '../factory/deeplink_visitor.dart';

abstract class IDeepLinkVisitorState {
  const IDeepLinkVisitorState();

  factory IDeepLinkVisitorState.fromUri(Uri uri) {
    return const GenericDeepLinkVisitorState();
  }

  void accept(IDeepLinkVisitor visitor);
}

class GenericDeepLinkVisitorState implements IDeepLinkVisitorState {
  const GenericDeepLinkVisitorState();

  @override
  void accept(IDeepLinkVisitor visitor) => visitor.visit(this);
}
