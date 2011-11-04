module Corollary where

open import Algebra
import Algebra.FunctionProperties as FunctionProperties
open FunctionProperties
open import Algebra.Structures
open import Level
open import Relation.Binary.Core
open import Relation.Binary.PropositionalEquality
  as PropEq
open PropEq.≡-Reasoning

data NatStar : Set where
  one  : NatStar
  succ : NatStar -> NatStar

postulate _*_ : NatStar -> NatStar -> NatStar

postulate *-isCommutativeMonoid : IsCommutativeMonoid _≡_ _*_ one

import Cancel
open Cancel {_} {_} {NatStar} (_≡_)
open import CancelativeAbelianMonoid

-- cancel : Cancel _*_
-- cancel = {!!}
-- can prove by induction, commutative, distributive, etc.
postulate cancel : Cancel _*_

isCancelativeAbelianMonoid : 
  IsCancelativeAbelianMonoid _≡_ _*_ one
isCancelativeAbelianMonoid
  = record {
      isCommutativeMonoid = *-isCommutativeMonoid
      -- isCommutativeMonoid = *-isCommutativeMonoid isCommutativeSemiring
    ; cancel = cancel 
    }

m : CancelativeAbelianMonoid Level.zero Level.zero
m = record {
      Carrier = NatStar
    ; _≈_ = _≡_
    ; _∙_ = _*_
    ; ε   = one
    ; isCancelativeAbelianMonoid = isCancelativeAbelianMonoid
    }

open import Noether
import Property
open Property Level.zero Level.zero m
import Theorem 
open Theorem Level.zero m

-- lemma1 : 2 isPrime
-- lemma1 = {!!}
postulate lemma1 : (succ one) isPrime

-- lemma2 : Noether Carrier (multiple 2)
-- lemma2 = {!!}
postulate lemma2 : Noether Carrier (multiple (succ one))

corollary : (succ one) isNotSquare
corollary = theorem (succ one) lemma1 lemma2
