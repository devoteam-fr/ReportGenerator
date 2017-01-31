# Fonction to no consider ',' in a sentense as separator (Loop to find and add ',' and don't count them as separator)
def concat_string_with_coma(str)
  save = str.split(',');
  tline = [];
  j = 0;
  a = 0;
  while (j != save.length)
    i = 0;
    tline[a] = save[j]
    while (i <= save[j].length)# && j != save.length)
      if (save[j][i] == '\\')
        j += 1;
        i = tline[a].length - 1;
        tline[a][i] = ',';
        tline[a] << save[j];
        i = 0;
      else
        i += 1;
      end
    end
    j += 1;
    a += 1;
  end
  return (tline)
end

# Sort Vuln if they are the save type and put them one after the other without creating a new title
def regroup_same_type_of_vuln(tab)
  n = 0;
  save = [];
  split_tab = [];
  split_save = [];
  save << tab[0];
  tab.delete_at(0);
  len = tab.length
  while (n != len)
    val = 0
    j = 0;
    split_save = save[n].split(',');
    while (j != tab.length)
      split_tab = tab[j].split(',');
      if (split_tab[0] == split_save[0])
        save << tab[j];
        tab.delete_at(j);
        n += 1;
        val = 1;
      end
      j += 1;
    end
    if (val == 0)
      save << tab[0];
      tab.delete_at(0);
      n += 1;
    end
  end
  return (save);
end

# Fonction to sort all vuln by criticality for the synthesis table
def sort_by_criticality(tab)
  n = 1;
  critique = [];
  majeure = [];
  mineure = [];
  info = [];
  sort_tab = [];

  while (n != tab.length)
    tline = tab[n].split(',');
    if (tline[3].capitalize == "Critique")
      critique << tab[n];
    elsif (tline[3].capitalize == "Majeure")
      majeure << tab[n];
    elsif (tline[3].capitalize == "Mineure")
      mineure << tab[n];
    elsif (tline[3].capitalize == "Information")
      info << tab[n];
    end
    n += 1;
  end
  sort_tab = fill_sort_tab(critique, majeure, mineure, info);
  return (sort_tab);
end

# Fonction related with "sort_by_criticality" which sort vuln and save in "sort_tab"
def fill_sort_tab(critique, majeure, mineure, info)
  sort_tab = [];
  i = 0;

  while (i != critique.length)
    sort_tab << critique[i];
    i += 1;
  end
  i = 0;
  while (i != majeure.length)
    sort_tab << majeure[i];
    i += 1;
  end
  i = 0;
  while (i != mineure.length)
    sort_tab << mineure[i];
    i += 1;
  end
  i = 0;
  while (i != info.length)
    sort_tab << info[i];
    i += 1;
  end
  return (sort_tab);
end

# Remove ',' at the first and the last position of the string for synth_tab and intro_tab_read for "Follow document" page 
def verif_coma_for_synth_tab(str)
  i = 0;
  a = -2;

  if (str[0] == ',')
    while (str[i] == ',')
      i += 1;
    end
    str = str.slice(i..-1);
  end
  if (str[-2] == ',')
    while (str[a] == ',')
      a -= 1;
    end
    str = str.slice(0..a);
  end
  return (str);
end

# Fonction to delete '"' and don't consider ',' in sentenses as separator
def regroup_with_coma(str)
  n = 0;
  str = verif_coma_for_synth_tab(str);
  tab = str.split(',');
  save = [];
  j = 0;

  while (n != tab.length)
    if (tab[n][0].ord == 34)
      save[j] = tab[n].slice(1..-1);
      while (tab[n][-1].ord != 34 && tab[n] != nil)
        n += 1;
        save[j] += ',' + tab[n].slice(0..-1);
      end
      save[j] = save[j].slice(0..-2);
      n += 1;
      j += 1;
    else
      save[j] = tab[n];
      n += 1;
      j += 1;
    end
  end
  return (save);
end
