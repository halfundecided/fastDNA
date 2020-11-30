#
# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.
#

CXX = c++
CXXFLAGS = -pthread -std=c++0x -march=native -lz
OBJS = common.o hash.o Kmer.o KmerIterator.o KmerIndex.o args.o dictionary.o productquantizer.o matrix.o qmatrix.o vector.o model.o utils.o fasttext.o
INCLUDES = -I.

opt: CXXFLAGS += -O3 -funroll-loops -DNDEBUG
opt: fastdna

debug: CXXFLAGS += -g -O0 -fno-inline
debug: fastdna

common.o: src/common.cpp src/common.h
	$(CXX) $(CXXFLAGS) -c src/common.cpp

hash.o: src/hash.cpp src/hash.hpp
	$(CXX) $(CXXFLAGS) -c src/hash.cpp

Kmer.o: src/Kmer.cpp src/hash.hpp src/Kmer.hpp
	$(CXX) $(CXXFLAGS) -c src/Kmer.cpp

KmerIterator.o: src/KmerIterator.cpp src/KmerIterator.hpp src/Kmer.hpp
	$(CXX) $(CXXFLAGS) -c src/KmerIterator.cpp

# KmerHashTable.o: src/KmerHashTable.cpp src/KmerHashTable.h src/Kmer.hpp
# 	$(CXX) $(CXXFLAGS) -c src/KmerHashTable.cpp

KmerIndex.o: src/KmerIndex.cpp src/*.hpp src/common.h src/KmerHashTable.h src/kseq.h
	$(CXX) $(CXXFLAGS) -c src/KmerIndex.cpp

args.o: src/args.cc src/args.h
	$(CXX) $(CXXFLAGS) -c src/args.cc

dictionary.o: src/dictionary.cc src/dictionary.h src/args.h src/*.hpp
	$(CXX) $(CXXFLAGS) -c src/dictionary.cc

productquantizer.o: src/productquantizer.cc src/productquantizer.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/productquantizer.cc

matrix.o: src/matrix.cc src/matrix.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/matrix.cc

qmatrix.o: src/qmatrix.cc src/qmatrix.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/qmatrix.cc

vector.o: src/vector.cc src/vector.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/vector.cc

model.o: src/model.cc src/model.h src/args.h
	$(CXX) $(CXXFLAGS) -c src/model.cc

utils.o: src/utils.cc src/utils.h
	$(CXX) $(CXXFLAGS) -c src/utils.cc

fasttext.o: src/fasttext.cc src/*.h src/*.hpp
	$(CXX) $(CXXFLAGS) -c src/fasttext.cc

fastdna: $(OBJS) src/fasttext.cc
	$(CXX) $(CXXFLAGS) $(OBJS) src/main.cc -lz -o fastdna

clean:
	rm -rf *.o fasttext
