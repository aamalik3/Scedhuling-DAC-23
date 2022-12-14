#include <systemc>
#include <vector>
#include <iostream>
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_fixed.h"
using namespace std;
using namespace sc_dt;
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
extern "C" void aes256_encrypt_ecb(char*, char*, char*);
extern "C" void apatb_aes256_encrypt_ecb_hw(volatile void * __xlx_apatb_param_ctx, volatile void * __xlx_apatb_param_k, volatile void * __xlx_apatb_param_buf) {
  // Collect __xlx_ctx__tmp_vec
  vector<sc_bv<8> >__xlx_ctx__tmp_vec;
  for (int j = 0, e = 96; j != e; ++j) {
    __xlx_ctx__tmp_vec.push_back(((char*)__xlx_apatb_param_ctx)[j]);
  }
  int __xlx_size_param_ctx = 96;
  int __xlx_offset_param_ctx = 0;
  int __xlx_offset_byte_param_ctx = 0*1;
  char* __xlx_ctx__input_buffer= new char[__xlx_ctx__tmp_vec.size()];
  for (int i = 0; i < __xlx_ctx__tmp_vec.size(); ++i) {
    __xlx_ctx__input_buffer[i] = __xlx_ctx__tmp_vec[i].range(7, 0).to_uint64();
  }
  // Collect __xlx_k__tmp_vec
  vector<sc_bv<8> >__xlx_k__tmp_vec;
  for (int j = 0, e = 32; j != e; ++j) {
    __xlx_k__tmp_vec.push_back(((char*)__xlx_apatb_param_k)[j]);
  }
  int __xlx_size_param_k = 32;
  int __xlx_offset_param_k = 0;
  int __xlx_offset_byte_param_k = 0*1;
  char* __xlx_k__input_buffer= new char[__xlx_k__tmp_vec.size()];
  for (int i = 0; i < __xlx_k__tmp_vec.size(); ++i) {
    __xlx_k__input_buffer[i] = __xlx_k__tmp_vec[i].range(7, 0).to_uint64();
  }
  // Collect __xlx_buf__tmp_vec
  vector<sc_bv<8> >__xlx_buf__tmp_vec;
  for (int j = 0, e = 16; j != e; ++j) {
    __xlx_buf__tmp_vec.push_back(((char*)__xlx_apatb_param_buf)[j]);
  }
  int __xlx_size_param_buf = 16;
  int __xlx_offset_param_buf = 0;
  int __xlx_offset_byte_param_buf = 0*1;
  char* __xlx_buf__input_buffer= new char[__xlx_buf__tmp_vec.size()];
  for (int i = 0; i < __xlx_buf__tmp_vec.size(); ++i) {
    __xlx_buf__input_buffer[i] = __xlx_buf__tmp_vec[i].range(7, 0).to_uint64();
  }
  // DUT call
  aes256_encrypt_ecb(__xlx_ctx__input_buffer, __xlx_k__input_buffer, __xlx_buf__input_buffer);
// print __xlx_apatb_param_ctx
  sc_bv<8>*__xlx_ctx_output_buffer = new sc_bv<8>[__xlx_size_param_ctx];
  for (int i = 0; i < __xlx_size_param_ctx; ++i) {
    __xlx_ctx_output_buffer[i] = __xlx_ctx__input_buffer[i+__xlx_offset_param_ctx];
  }
  for (int i = 0; i < __xlx_size_param_ctx; ++i) {
    ((char*)__xlx_apatb_param_ctx)[i] = __xlx_ctx_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_k
  sc_bv<8>*__xlx_k_output_buffer = new sc_bv<8>[__xlx_size_param_k];
  for (int i = 0; i < __xlx_size_param_k; ++i) {
    __xlx_k_output_buffer[i] = __xlx_k__input_buffer[i+__xlx_offset_param_k];
  }
  for (int i = 0; i < __xlx_size_param_k; ++i) {
    ((char*)__xlx_apatb_param_k)[i] = __xlx_k_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_buf
  sc_bv<8>*__xlx_buf_output_buffer = new sc_bv<8>[__xlx_size_param_buf];
  for (int i = 0; i < __xlx_size_param_buf; ++i) {
    __xlx_buf_output_buffer[i] = __xlx_buf__input_buffer[i+__xlx_offset_param_buf];
  }
  for (int i = 0; i < __xlx_size_param_buf; ++i) {
    ((char*)__xlx_apatb_param_buf)[i] = __xlx_buf_output_buffer[i].to_uint64();
  }
}
