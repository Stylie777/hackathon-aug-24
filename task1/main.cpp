#include <cstddef>
#include <fstream>
#include <iostream>
#include <istream>
#include <iterator>
#include <map>
#include <memory>
#include <ostream>
#include <regex>
#include <vector>

enum type_e{
    TYPE_FILE,
    TYPE_DIR,
    TYPE_UNKNOWN
};

struct node{
    std::string name;
    type_e type;
    node *parent_dir;
    int depth;
};

// static void PreOrderDFS(node *n);

using namespace std;

map<string, node *> name_to_node;
map<node, node> node_to_parent_node;
vector<string> file_lines;

string extract_deepest_path(node &deepest_node) {
    string path;
    path = deepest_node.name;
    node &n = *deepest_node.parent_dir;

    while (n.parent_dir != nullptr) {
        path = n.name + "/" + path;
        n = *n.parent_dir;
    }
    path = n.name + path;
    return path;
}

int main(int argc, char * argv[]) {

    string contents;
    const size_t size = 1024; 
    // Allocate a character array to store the directory path
    char buffer[size];        
    string filename = "actual.txt";

    // We start at the root directory so it is a given that this is at position 0
    node root = {
        .name = "/",
        .type = TYPE_DIR,
        .parent_dir = nullptr,
        .depth = 0,

    };
    name_to_node[root.name] = &root;
    node *parent_node = &root;

    // build_tree(filename);

    ifstream file;
    // parent_node = name_to_node.find("/")->second;
    int depth = 0;

    file.open(filename);
    if(!file.is_open())
    {
        std::cout << "File failed to open\n";
        exit(1);
    }

    string s;
    while (getline(file, s)){
        int start,end = 0;
        std::vector<string> line;
        while((start = s.find_first_not_of(" ", end)) != string::npos) {
            end = s.find(" ", start);
            line.push_back(s.substr(start, end - start));
        }

        node *n = new node;
        if(line[1] == "cd") {
            if (line[2] == "..") {
                parent_node = n->parent_dir;
                depth--;
            }
            else{
                parent_node = name_to_node.find(line[2])->second;
                depth++;
            }
            continue;
        }
        // Lines including only the dollar sign are commands that can be ignored.
        else if(line[1] == "ls") {
            continue;
        }
        else if(line[0] == "dir") {
            n->type = TYPE_DIR;
        }
        else {
            n->type = TYPE_FILE;
        }

        n->name = line[1];
        n->parent_dir = parent_node;
        n->depth = depth;

        name_to_node[n->name] = n;
    }

    file.close();

    node *deepest_node;
    deepest_node = name_to_node.find("/")->second;
    int total_depth = 0;
    int no_of_files = 0;
    for(auto entry : name_to_node) {
        if(entry.second->depth > deepest_node->depth)
            deepest_node = entry.second;

        if(entry.second->type == TYPE_FILE) {
            total_depth += entry.second->depth;
            no_of_files++;
        }
    }

    string deepest_path = extract_deepest_path(*deepest_node);

    cout << no_of_files << ", " << '"' << deepest_path << '"' << ", " << (double)total_depth/no_of_files << "\n";

    return 0;
}

