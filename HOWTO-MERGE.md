# Merging upstream

To merge upstream changes I currently do the following
(while manually fixing merge conflicts along the way):

1. Merge upstream tag into branch upstream-split and generate project.mml.d
   by running script scripts/split-project.mml.py:
```
	git checkout upstream-split
	git merge vX.Y.Z
	scripts/split-project.mml.py
	git commit --amend`
```
   
2. Tag as `vX.Y.Z-split`:

```
	git tag vX.Y.Z-split
```

3. Merge `vX.Y.Z-split` into branch `upstream+l10n`:
```
        git checkout upstream+l10n
	git merge vX.Y.Z-split
```

If merge has conflicts in project.mml check layer order and call:
```
	scripts/concat-split-project.mml.py >project.mml
	git commit --amend
```


4. Tag as `vX.Y.Z-l10n0`

```
        git tag vX.Y.Z-l10n0
```

5. Merge `vX.Y.Z-l10n0` into master branch:
```
        git checkout master
        git merge vX.Y.Z-l10n0
```

Again, if merge has conflicts in project.mml check layer order and call:
```
        scripts/concat-split-project.mml.py >project.mml
        git commit --amend
```


6. Finally tag master branch as `vX.Y.Z-de0`:
```
        git tag vX.Y.Z-de0
```

Sven Geggus 2019-08-29
