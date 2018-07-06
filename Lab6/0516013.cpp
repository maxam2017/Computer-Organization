#include <iostream>
#include <math.h>
#include <string>
#include <iomanip>
#include <fstream>

using namespace std;

struct cache_content{
    unsigned int  tag;
    int ref;
};

const int K=1024;

void simulate(string fn, int cache_size, int block_size, int way){
    unsigned int tag,index,x;

    int offset_bit = (int) log2(block_size);
    int index_bit = (int) log2(cache_size/block_size/way);
    int line= cache_size>>(offset_bit);

    cache_content *cache =new cache_content[line];
    //cout<<"cache line:"<<line<<endl;
    for(int j=0;j<line;j++){
        cache[j].ref=0;
    }

    fstream fs;
    fs.open(fn,ios::in);
    if(!fs)
        exit(1);
    string h,m;
    int miss=0,count=0,t=0;
    while(fs>>hex>>x){
        count++;
        bool hit = false;
        index=(x>>offset_bit)&((line/way)-1);
        tag=x>>(index_bit+offset_bit);
        for(int i=0;i<way;i++){
            if(cache[index*way+i].ref && cache[index*way+i].tag==tag){
                cache[index*way+i].ref = count;
                h+=to_string(count)+',';
                hit = true;
                break;
            }
        }
        if(!hit){
            int min = count, pos;
            for(int i=0;i<way;i++){
                // find empty
                if(cache[index*way+i].ref == 0){
                    pos = i;
                    break;
                }
                // find old
                if(cache[index*way+i].ref<min){
                    min = cache[index*way+i].ref;
                    pos = i;
                }
            }
            cache[index*way+pos].tag = tag;
            cache[index*way+pos].ref = count;
            miss++;
            m+=to_string(count)+',';
        }
        
    }
    fs.close();
    cout<<"Hits instructions:";
    cout<<h.substr(0,h.size()-1)<<endl;
    cout<<"Misses instructions:";
    cout<<m.substr(0,m.size()-1)<<endl;
    cout<<"Miss rate:"<<(miss/(double)(count))*100<<'%'<<endl;
    //cout<<(miss/(double)(count))*100<<',';
    
    delete [] cache;
}

int main(){
    string filename;
    int cache,block,associativy;
    //請依需輸入檔名,cache大小,block大小,associativy
    cout<<"filename:";
    cin>>filename;
    cout<<"block size(Byte):";
    cin>>block;
    cout<<"cache size(KB):";
    cin>>cache;
    cout<<"associativy:";
    cin>>associativy;
    simulate(filename,cache*K,block,associativy);
    /***********************************************/
    /*               for problem a                 */
    /***********************************************/
	/*
    for(int i=1;i<=256;i*=2){
		cout<<"cache_size:"<<i<<"KB"<<endl;
		cout<<"====================="<<endl;
		for(int j=16;j<=256;j*=2){
			cout<<"block_size:"<<j<<'B'<<endl;
			simulate(i*K, j,1);
		}
		cout<<endl;
	}
    */
    /***********************************************/
    /*               for problem b                 */
    /***********************************************/
	/*
    for(int i=1;i<=256;i*=2){
		cout<<"cache_size:"<<i<<"KB"<<endl;
		cout<<"====================="<<endl;
		for(int j=1;j<=8;j*=2){
			//cout<<"associativity:"<<j<<endl;
			simulate(i*K, 32, j);
		}
		cout<<endl;
	}*/
}
