{ lib
, buildPythonPackage
, fetchFromGitHub
, elementpath
, lxml
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  version = "1.11.0";
  pname = "xmlschema";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "sissaschool";
    repo = "xmlschema";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-WnX4MmrHHELzUcUnP34A+kK0x4ARm6qrEN7+KQk9/Ts=";
  };

  propagatedBuildInputs = [
    elementpath
  ];

  checkInputs = [
    lxml
    pytestCheckHook
  ];

  # Ignore broken fixtures, and tests for files which don't exist.
  # For darwin, we need to explicity say we can't reach network
  disabledTests = [
    "export_remote"
    "element_tree_import_script"
  ];

  disabledTestPaths = [
    "tests/test_schemas.py"
    "tests/test_memory.py"
    "tests/test_validation.py"
  ];

  pythonImportsCheck = [ "xmlschema" ];

  meta = with lib; {
    description = "XML Schema validator and data conversion library for Python";
    homepage = "https://github.com/sissaschool/xmlschema";
    license = licenses.mit;
    maintainers = with maintainers; [ jonringer ];
  };
}
