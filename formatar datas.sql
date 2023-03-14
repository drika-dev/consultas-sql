select
    convert(varchar, getdate(),   0) ' 0: mmm dd aaaa hh:mm XX',
    convert(varchar, getdate(),   1) ' 1: mm/dd/aa',
    convert(varchar, getdate(),   2) ' 2: aa.mm.dd',
    convert(varchar, getdate(),   3) ' 3: dd/mm/aa - Brasil 2 dig',
    convert(varchar, getdate(),   4) ' 4: dd.mm.aa',
    convert(varchar, getdate(),   5) ' 5: dd-mm-aa',
    convert(varchar, getdate(),   6) ' 6: dd mmm aa',
    convert(varchar, getdate(),   7) ' 7: mmm dd, aa',
    convert(varchar, getdate(),   8) ' 8: hh:mm:ss',
    convert(varchar, getdate(),   9) ' 9: mmm dd aaaa hh:mm:ss:mi XX',
    convert(varchar, getdate(),  10) '10: mm-dd-aa',
    convert(varchar, getdate(),  11) '11: aa/mm/dd',
    convert(varchar, getdate(),  12) '12: aammdd',
    convert(varchar, getdate(),  13) '13: dd mmm aaaa hh:mm:ss:mi',
    convert(varchar, getdate(),  14) '14: hh:mm:ss:mi',
    convert(varchar, getdate(), 100) '100 = 0',
    convert(varchar, getdate(), 101) '101: dd-mm-aaaa',
    convert(varchar, getdate(), 102) '102: aaa.mm.dd',
    convert(varchar, getdate(), 103) '103: dd/mm/aaaa - Brasil 4 dig', 
    convert(varchar, getdate(), 104) '104: dd.mm.aaaa',
    convert(varchar, getdate(), 105) '105: dd-mm-aaaa',
    convert(varchar, getdate(), 106) '106: dd mmm aaaa',
    convert(varchar, getdate(), 107) '107: mmm dd, aaaa',
    convert(varchar, getdate(), 108) '108: hh:mm:ss',
    convert(varchar, getdate(), 109) '109 = 09',
    convert(varchar, getdate(), 110) '110: mm-dd-aaaa',
    convert(varchar, getdate(), 111) '111: aaaa-mm-dd',
    convert(varchar, getdate(), 112) '112: aaaammdd',
    convert(varchar, getdate(), 113) '113 = 13',
    convert(varchar, getdate(), 114) '114 = 14'
