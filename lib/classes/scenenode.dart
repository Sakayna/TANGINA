import 'package:vector_math/vector_math_64.dart' as vector;
class SceneNode {
  final String name;
  final String modelPath;
  final vector.Vector3 position;
  vector.Vector3 scale;
  vector.Vector3 _origScale;
  final bool? canPan;
  final bool? canRotate;
  final bool? canScale;

  SceneNode({
    required this.name,
    required this.modelPath,
    required this.position,
    required this.scale,
    this.canPan,
    this.canRotate,
    this.canScale,
  }) : _origScale = scale.clone();

  vector.Vector3 get originalScale => _origScale;
  set originalScale(vector.Vector3 scale) {
    _origScale = scale;
  }
}