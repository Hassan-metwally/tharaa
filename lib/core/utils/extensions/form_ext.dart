part of core;

extension FormExt on GlobalKey<FormState> {
  bool validateAndScrollToFirstError() {
    final formState = currentState;
    if (formState == null) return false;

    final bool isValid = formState.validate();
    if (isValid) return true;

    // Find the first error field by traversing the widget tree
    BuildContext? firstErrorContext;

    void findFirstErrorField(Element element) {
      if (firstErrorContext != null) return;

      // Check if this element has a FormFieldState ancestor with an error
      final formFieldState = element.findAncestorStateOfType<FormFieldState<dynamic>>();
      if (formFieldState != null && formFieldState.hasError) {
        // Found a field with error, get its context
        firstErrorContext = formFieldState.context;
        return;
      }

      // Recursively visit children
      element.visitChildElements(findFirstErrorField);
    }

    // Start traversal from the form's context
    formState.context.visitChildElements(findFirstErrorField);

    // If we found an error field, scroll to it
    if (firstErrorContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final renderObject = firstErrorContext?.findRenderObject();
        if (renderObject != null && renderObject.attached) {
          Scrollable.ensureVisible(
            firstErrorContext!,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: 0.1, // Scroll to show the field near the top (10% from top)
          );
        }
      });
    }

    return false;
  }
}
