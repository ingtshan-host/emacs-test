#!/bin/bash

#
# 汉字转拼音
#

yzypy() {
    bd="$1"
    py=$(rg "$1" "./tool/hz2py/dict/kMandarin_8105.txt" |
    # 过滤出声调
    cut -d "#" -f 1 |
    cut -d ":" -f 2 |
    # 去掉空格
    sed 's/\ //g')

    # 去掉声调
    # 未使用到的声调：
    # êê̄ếê̌ề ẑ ĉ ŝ ŋ
    # ÊÊ̄ẾÊ̌Ề Ẑ Ĉ Ŝ Ŋ
    py=$(echo -n "$py" |
    sed 's/[āáǎà]/a/g' |
    sed 's/[ĀÁǍÀ]/a/g' |
    sed 's/[ōóǒò]/o/g' |
    sed 's/[ŌÓǑÒ]/o/g' |
    sed 's/[ēéěè]/e/g' |
    sed 's/[ĒÉĚÈ]/e/g' |
    sed 's/[īíǐì]/i/g' |
    sed 's/[ĪÍǏÌ]/i/g' |
    sed 's/[ūúǔù]/u/g' |
    sed 's/[ŪÚǓÙ]/u/g' |
    sed 's/[ǖǘǚǜ]/ü/g' |
    sed 's/[ǕǗǙǛ]/ü/g' |
    sed 's/[ńňǹ]/n/g'  |
    sed 's/[ŃŇǸ]/n/g'  |
    sed 's/[m̄ḿm̀]/m/g'  |
    sed 's/[M̄ḾM̀]/m/g')
    # 确认结果
    if [[ ${#py} -lt 1 ]] ||  [[ ${#py} -gt 8 ]] ; then
        echo -n "$bd"
    else
        echo -n "$py"
    fi
}

#For read to keep space
IFS=''


#分离字符以便逐个处理
echo "$1" | sed -e 's/\(.\)/\1\n/g'|
    #逐字查找
    while read -r zi
    do
        if [[ "$zi" =~ [!-~\ ] ]] ; then
            # 不处理 ASCII 字符
            echo -n "$zi"
        else
            yzypy "$zi"
        fi
    done


