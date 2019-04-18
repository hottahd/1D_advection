#!/usr/bin/python
# -*- coding: utf-8 -*-

# src/ 以下に存在する.f90ファイルを検索して
# ファイルの中に含まれるuse文からMakefileで使う
# 依存関係を示すファイル(make/deps)を
# 生成するプログラム

import re, glob
from pathlib import Path

def obtain_deps(filename):
    deps = []
    # filenameはそれぞれの.f90ファイルが代入される
    f = open(filename) 
    # reは、正規表現を使うpython標準ライブラリ
    # compileすることで、先にパターンを定義する
    #
    # ^  : 先頭を表す
    # \s : 任意の空白文字(タブなどでもok)
    # *  : 0回以上の繰り返し
    # +  : 1回以上の繰り返し
    # () : グループ化
    # \S : 任意の空白以外の文字
    # .  : 任意の一文字
    # $  : 文字列の末尾
    #
    use_line_re = re.compile("^\s*use\s+(\S.+)\s*$")
    for line in f:
        # それぞれの行で上の正規表現にマッチするものがあるか探す
        match = use_line_re.search(line)
        if match:
            # マッチするものがあったら , で区切られるまでを
            # depに追加する。自分のプログラムでは、大体
            # use test, only: 
            # という形になっているので、これで問題ない
            # group(1)とすることでuseは削除される
            dep = match.group(1).split(",")[0]
            deps.append(dep)
    return deps

def write_deps(filename,deps,outf,outputfile):
    # 最初のsplitでディレクトリを削除して、
    # 次のsplitで.f90を.oに変更する
    filename_only = filename.split("/")[-1].split(".")[0]+".o"
    deps_obj = []
    for dep in deps:
        deps_obj.append(dep+".o")
    # join関数を使うことで、リストに保存されている.oの文字列をつなげる
    outf.write("%s: %s\n" % (filename_only," ".join(deps_obj)))

def main():
    filenames = glob.glob('src/**/*.f90',recursive=True)
    outputfile = "make/deps"
    outf = open(outputfile,"w")
    outf.write("### This is auto-generated file. DO NOT EDIT\n")
    for filename in filenames:
        deps = obtain_deps(filename)
        write_deps(filename,deps,outf,outputfile)
    outf.close()

if __name__ == "__main__":
    main()
