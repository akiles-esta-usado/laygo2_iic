# Translation function so we can use sed program with paths
translated=""
sed_translater () {
	translated="$(echo $1 | sed 's:\/:\\/:g')"
}


sed_translater "/foss/designs/laygo2"
LAYGO2_OLD_PYLIBRARY=$translated
sed_translater "/foss/designs/laygo2_reduced_workspace"
LAYGO2_OLD_WORKSPACE=$translated


sed_translater $(readlink -f ./../laygo2)
LAYGO2_NEW_PYLIBRARY=$translated
sed_translater $(readlink -f ./../laygo2_reduced_workspace)
LAYGO2_NEW_WORKSPACE=$translated



sed -i "s/$LAYGO2_OLD_PYLIBRARY/$LAYGO2_NEW_PYLIBRARY/g" .maginit
sed -i "s/$LAYGO2_OLD_WORKSPACE/$LAYGO2_NEW_WORKSPACE/g" .maginit

sed -i "s/$LAYGO2_OLD_PYLIBRARY/$LAYGO2_NEW_PYLIBRARY/g" compile_tcl.sh
sed -i "s/$LAYGO2_OLD_WORKSPACE/$LAYGO2_NEW_WORKSPACE/g" compile_tcl.sh

sed -i "s/$LAYGO2_OLD_PYLIBRARY/$LAYGO2_NEW_PYLIBRARY/g" laygo2_example/paths.py
sed -i "s/$LAYGO2_OLD_WORKSPACE/$LAYGO2_NEW_WORKSPACE/g" laygo2_example/paths.py

