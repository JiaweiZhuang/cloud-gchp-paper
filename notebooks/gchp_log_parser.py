import pandas as pd

# see http://wiki.seas.harvard.edu/geos-chem/index.php/GCHP_Timing_Tests for interpretation of log files

def timing_from_log(filename):
    component_keys = ['Times for GIGCchem', 'Times for DYNAMICS', 'Times for EXTDATA', 'Times for HIST']
    total_key = 'User time  System Time   Total Time'
    
    timing_info = {}

    with open(filename, "r") as f:
        line = f.readline()
        while(line):
            for key in component_keys:
                if key in line:
                    # print(f.readline().split()[-1])
                    timing_info[key[10:]] = float(f.readline().split()[-1])

            if total_key in line:
                f.readline()
                # print(f.readline().split()[-1])
                timing_info['Total'] = float(f.readline().split()[-1])

            line = f.readline()
    
    return timing_info

def timing_from_multi_logs(node_list, core_per_node, filename_template):
    
    time_info_list = [timing_from_log(filename_template.format(node, node*core_per_node)) 
                      for node in node_list]
    
    df = pd.DataFrame.from_records(time_info_list)
    
    df['N'] = node_list
    df['n'] = df['N'] * core_per_node
    
    return df