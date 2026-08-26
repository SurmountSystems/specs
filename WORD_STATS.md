# Word stats

This file tracks unique English words in Surmount authored markdown in this repository. Tokens are ASCII letters only, folded to lowercase. Digits are not words. beastdb is one token. RFC folds to rfc.

Proven tokens are lowercased CATE L_n catalog entries from 0005_CATE.md, plus the RFC 2119 requirement keywords already named in 0000_spec.md Clause 4.1 and 0005_CATE.md Clause 3.9 (must, shall, should, required, recommended, may, optional). That is not a second CATE catalog. CATE owns domain words. RFC 2119 owns those requirement keywords. The CATE catalog is case sensitive. This scan folds to lowercase, so pairs such as Markdown and markdown are one unique word.

This tracking is not a proof that every English sentence is CATE. The leftover unstack floor in 0005_CATE.md remains a separate check.

Scope is root numbered NNNN markdown files, README.md, AGENTS.md, RESIDUAL.md, and VOCABULARY.md. This file is not in the scan. Vendor trees under ref, the Lean 4 skill pack, Lake build output, Nix result links, and git metadata are not in the scan. Lean comments are not in the scan.

The Lean program word_stats writes this file and fails when this file is stale.

## Headline

Unique word count: 2550
Proven unique count: 213
Percent of unique words that are proven: 8.35%
Total occurrence count: 65878
Proven occurrence count: 10556
Percent by prevalence: 16.02%

CATE catalog token count (case sensitive): 213
Folded catalog unique count: 206
Proven set size after union with RFC 2119 keywords: 213

## Files scanned

0000_spec.md
0001_DOGE.md
0002_Systems_Lean.md
0003_beastdb.md
0004_SSSSS.md
0005_CATE.md
0006_RSI.md
0007_CI.md
0008_Formal_Vibefication.md
0010_Surmount_Systems.md
AGENTS.md
README.md
RESIDUAL.md
VOCABULARY.md

## Unique words

Each line is the lowercased token, a space, the occurrence count, and the word proven when that token is in the proven set.

```text
a 1824
aarch 2
ab 1
abbreviate 1
abbreviated 1
abbreviation 1
abi 5 proven
able 5
about 44
above 2
absence 3
absent 7
absint 4 proven
academic 1
accept 3
acceptable 1
acceptance 3
accepted 15
access 27
accessed 18
acid 14 proven
acknowledgments 23 proven
acronym 2
across 36
act 3
actions 6
actually 6
ad 1
add 41
added 4
adding 14
addition 2
additional 7
additions 1
address 1
addresses 2
adds 2
adjacent 1
adjective 1
adjectives 1
adopted 2
advancing 1
affine 16 proven
after 32
again 8
against 7
agent 35
agents 77
aggregate 1
ahead 12
ai 4
aims 1
algorithm 5
algorithms 3
aliases 2
aligned 1
aligns 1
all 24
allocation 1
allowed 10
allows 10
alone 3
along 3
alongside 1
alpha 11
already 62
also 73
alternate 1
alternatives 1
always 8
ambiguity 8
ambiguous 7
american 81
among 15
an 143
and 1633
another 13
ansi 3 proven
answer 2
answered 1
any 46
anyone 10
anything 2
aot 2
apis 3 proven
apology 1
app 4
appear 16
appears 14
apple 1
application 18
applications 1
applied 2
applies 23
apply 9
apps 7
arbitrary 2
architecture 1
architectures 1
archives 5
are 486
arguments 1
around 1
art 38
artifact 18
artifacts 20
as 808
ascii 63 proven
ask 9
asked 21
asking 4
asks 3
aspell 72 proven
aspelldicts 1
aspellwithdicts 12 proven
assembly 5
asserts 2
assets 1
assign 10
assigned 113
assigning 1
assignment 8
assigns 1
assistance 2
associated 1
assume 3
assumed 4
assumptions 4
assurance 26
at 116
atkey 4 proven
atom 1
atomicity 4 proven
atoms 1
attached 2
attaches 1
attention 1
attribute 2
audience 1
author 17
authored 11
authoring 2
authoritative 15
authority 8
authorization 1
authorize 2
authors 112
automated 5
autoprove 3
auxiliary 3
availability 9
available 11
avoid 1
away 1
b 29
back 28
backed 1
background 9
backlink 5
backward 3
ban 15
bans 1
bar 4
bare 2
based 3
baseline 1
basename 7 proven
basenames 2 proven
bash 32
baz 3
bc 1
be 288
beast 9
beastdb 257 proven
beatitudes 5 proven
because 20
become 3
becomes 2
been 15
before 52
beginning 1
behavior 18
behind 2
being 4
belong 6
below 2
bentnib 1
beside 2
best 21
better 2
between 11
beyond 12
bg 5 proven
bin 18 proven
binaries 8
binary 37
binding 7
binds 3
bio 3
bips 6 proven
bit 38
bitcoin 7
bitdevs 4 proven
bitmask 22 proven
black 7
blank 6
bleed 3
blobs 3
block 8
blocker 7
blockquote 4 proven
blockquotes 4 proven
blocks 10
blue 6
board 1
body 10
bool 2
bootstrap 16
bootstrapped 33 proven
bootstrapping 6
both 18
bounce 1
bounded 1
branch 1
brand 1
break 5
breaks 5
briefly 1
bright 7
brightness 1
broken 4
buffer 1
bug 1
build 83
builder 20
builders 1
building 3
builds 4
built 5
builtins 2
bulk 2
bullet 4
bullets 6
bump 4
bumping 2
bumps 1
bundled 1
but 11
by 216
byte 38
bytes 16
c 73
caches 1
cachix 2 proven
call 1
called 1
calling 2
calls 5
can 65
cancel 1
candidate 1
canned 1
cannot 14
canon 7
canonical 64
capability 1
capacity 7
capital 9
capitalization 10
caption 1
captions 5
carbonado 94 proven
cargo 4 proven
carriage 2
carries 2
carry 7
case 7
catalog 86
cate 364 proven
catespecnumber 3
causes 1
cc 1
ccomp 9 proven
cd 1
cell 1
cells 1
change 26
changed 3
changelog 29 proven
changes 11
channel 9
channels 2
char 1
character 9
characteristics 1
characters 6
chat 9
check 297 proven
checkability 5 proven
checkable 21 proven
checked 24
checker 122
checkers 12
checking 8
checklist 7
checklists 2
checkout 3
checkpoint 4
checks 96 proven
checksum 6
checksummed 4 proven
choice 6
chooses 1
choosing 1
chosen 3
ci 97
citation 35
citations 24
cite 22
cited 36
cites 22
citing 4
civilizations 1
claim 148
claimed 39
claiming 16
claims 52
clamped 3
clarification 2
clarifies 1
clarify 1
class 5
classic 2
clause 494
clauses 29
clean 1
cleanly 1
clear 10
clearly 6
cli 2 proven
clone 5
clones 1
closed 4
closing 2
cocomo 14 proven
code 71
codebase 3 proven
coded 1
codes 1
coding 1
coined 1
collected 1
collection 14
collector 1
collision 12
collisions 1
color 21
colors 30
column 26
com 58
combinations 1
combined 5
command 12
commandments 2
commands 2
comment 5
comments 21
commercial 10
commit 87 proven
commits 15
committed 12
committing 1
common 8
community 8
companion 92
compared 2
compares 1
comparison 2
compatibility 6
compatible 4
compcert 97 proven
compilation 40
compile 19
compiled 36
compiler 48
compiles 1
complete 52
completed 1
completes 1
complexity 1
component 3
components 26
compose 1
composed 2
composes 4
composition 39
compound 1
compounds 5
concern 2
concise 48
concurrency 6
concurrent 1
confidence 14
config 4
configuration 1
configure 1
confirmed 4
conform 25
conformance 76
conformant 4 proven
conforming 94
conforms 28
conjunction 2
conjuncts 1
consecutive 6
consist 1
consistency 20
consistent 7
consisting 1
constraints 1
constructor 9
contain 30
contains 18
content 4
contents 4
context 1
continuation 1
continue 3
continues 1
continuity 2
continuous 72
contract 100
contracts 2
contradict 1
contradiction 3
contradictory 1
contrast 8
contributions 1
contributors 2
control 6
controls 4
convenience 2
convention 1
conversion 1
convert 1
converted 1
converting 1
copied 1
copies 22
copy 34
copyright 21
core 48
correct 1
corrected 1
correctly 2
correctness 1
corrects 2
correspondence 3
correspondences 2
corresponding 1
cosmology 7
cost 4
count 1
counting 1
counts 6
cover 8
coverage 4
covers 5
cr 6
crate 1
create 27
creates 1
creating 10
credit 9
critical 14
cross 3
cryptoquick 11 proven
crystal 1
cultural 9
current 19
currentsystem 2
curry 7 proven
cyan 4
cycle 2
d 13
darwin 4 proven
dashes 2
data 13
date 8
dated 4
dates 3
day 1
dd 1
debug 5
decidable 1
decide 2
decided 1
decimal 5
decision 3
decisions 1
declarations 34
declare 4
declared 12
declares 2
decode 1
decoder 5
dedication 1
dedup 1
deeper 1
default 16
deferred 11
define 6
defined 32
defines 20
definite 1
definition 6
definitions 23
delete 3
deleting 14
deliberate 5
deliberately 1
deliverable 1
deliverables 2
dense 8
depend 2
dependent 8
depth 1
derivation 2
derived 1
describe 1
described 16
describes 11
describing 1
description 2
descriptive 17
design 14
designation 5
designations 5
desired 1
detail 6
details 1
detect 2
detection 1
determinism 4
deterministic 17 proven
dev 5
develop 6
developer 1
development 8
diagnostics 7
diagrams 2
dictionaries 1
dictionary 2
did 1
diff 1
different 22
differs 1
diffusion 5
digest 1
digit 11
digital 6
digits 3
din 3 proven
dir 2
direct 2
direction 1
directly 18
directories 8
directory 14
direnv 5 proven
disagree 2
disagreement 3
discard 1
discarded 4
discarding 1
discipline 2
discouraged 1
discovers 2
discovery 7
discretion 1
discussion 7
dishonest 1
disjoint 20
disk 20
display 5
displays 7
disposable 12
distinct 47
distinctions 4
distinguish 1
distribute 10
distributed 2
distribution 10
dithering 7
do 176
doc 6
docs 6
document 473
documentation 2
documented 7
documents 34
does 382
doge 62 proven
domain 25
don 16
done 33
dont 15
draft 4
drawn 1
drift 4
drive 1
driver 1
drop 7
dropped 1
dry 2
dual 9
dump 5
duplicate 7
durability 3
durable 55
e 18
each 45
earlier 1
early 2
ecma 59 proven
ecosystem 2
ecosystems 2
edges 2
edit 15
editing 2
edition 16
editor 11
edits 2
effect 1
efficiency 1
effort 44
eight 23
either 21
electronic 2
element 1
elevate 2
elevated 5
elevating 1
elevation 1
elf 17
ellipsis 1
else 4
em 1
embed 1
embedded 2
emission 8
emissive 18 proven
emit 70
emits 21
emitted 6
emitting 4
emphasize 1
empty 13
emulators 2
en 19
encode 48
encoded 25
encodedlines 11
encoder 1
encodes 16
encoding 95
encodings 245 proven
encountered 2
encrypted 2
end 8
ending 2
endings 6
endpoint 1
endpoints 1
ends 2
enforce 2
enforced 5
enforces 9
engine 6
engineering 2
engines 1
english 156
enough 21
enter 2
entire 1
entries 14
entry 26
enumerate 1
enumerations 3
env 1
environment 1
environments 7
eof 2 proven
eol 2 proven
equal 3
equalities 4 proven
equals 6
equating 1
equivalent 4
era 5
erased 3
erasure 2
error 9
especially 2
essays 16
establish 3
established 1
establishes 10
eval 9
evaluate 2
evaluation 15
evaluator 1
even 3
every 100
everyday 1
everything 3
evidence 1
evolves 3
evolving 2
exact 22
exactly 19
example 36
examples 11
except 3
exception 24
exceptions 4
excess 5
exclude 4
excluded 3
excludes 1
excluding 1
exclusion 2
exclusions 1
excuse 4
executable 11
exempt 7
exemptions 1
exist 65
existed 1
existing 5
exists 57
exit 3
expand 3
expands 1
expansion 1
expected 5
experimental 1
explain 1
explanation 2
explicit 11
explicitly 9
expr 2
expressed 4
expression 2
expressions 1
ext 2
extended 3
extension 5
external 42
extra 7
extreme 1
eyes 1
f 12
facilities 2
facing 1
fact 16
factories 3
factory 4
facts 14
fail 26
failed 2
failing 16
fails 29
failure 6
fake 8
fall 2
fallback 4
false 23
familiar 3
family 2
fargo 188 proven
fat 2
feature 2
features 5
federal 13
feed 5
feelings 1
fence 4
fenced 29
fences 6
fencing 7
fetch 1
ff 5
ffff 2
ffffff 1
ffi 3 proven
fg 5 proven
field 2
fields 2
figures 2
file 293
filename 2
filenames 5
files 61
fileset 1
fill 1
filled 1
filling 1
filter 1
final 2
finalized 1
find 7
findings 3
fine 5
finish 1
finite 2
first 55
fit 5
fits 3
five 6
fix 7
fixed 4
fixes 3
fixos 3 proven
fixture 1
fixtures 17
flag 5
flags 7
flake 99 proven
flakes 4 proven
flat 5
float 2
floating 1
floor 40
floyd 13 proven
fold 1
folded 3
folder 5
folds 3
follow 39
followed 1
following 33
follows 14
foo 4
for 842
forbade 1
forbidden 10
forbids 6
force 3
forced 1
foreground 3
foreign 12
form 371
formal 194
formalization 3
formalize 1
formalizing 2
formally 2
formalvibeficationproofs 13
formalvibeficationspec 21
formalvibeficationspecnumber 4
format 5
formats 2
formatting 1
formed 2
formerly 2
forms 8
found 1
foundation 1
four 10
fragment 1
fragments 4
free 35
freely 1
freestanding 100 proven
freeze 6
freezes 1
friction 3
from 132
full 33
fully 50
fun 3
function 12
functions 1
future 9
g 13
gains 1
gaps 7
garbage 15
gate 57
gatekeeper 4
gates 2
gaussian 6
general 5
generated 12
generation 13
gerund 1
giant 1
git 173
github 28 proven
gitignore 3 proven
gitignored 2 proven
gitlab 3 proven
gitlinks 4 proven
give 2
given 11
glob 1
global 1
go 3
goes 4
golf 3
gone 1
good 1
gov 3
govern 8
governing 1
grade 2
grainier 3 proven
grant 2
grants 3
graphic 1
graphical 10
grayscale 3 proven
greater 2
greek 3
green 22
grok 25 proven
grow 1
growth 1
guesses 3
gui 2 proven
guidance 1
guidelines 15
h 12
ha 2 proven
half 6
hand 3
handle 2
handling 2
hard 6
hardcoded 1
hardware 5
harness 1
has 204
hash 9
hashed 2
hashing 15
have 19
having 5
he 1
headed 1
header 2
headers 5
heading 42
headings 25
healthy 1
heap 1
heed 7 proven
help 1
helper 3
helpers 1
here 65
herein 8
hermetic 13
heuristic 8
heuristics 2
hex 4
hide 3
hides 13
high 59
higher 1
his 4
historic 2
history 27
hoc 1
hold 15
holding 1
holds 32
hole 4
holy 3
home 17
homes 14
honest 11
honesty 31
honorable 5
hook 23 proven
hooks 10 proven
horizontal 1
host 18
hosts 4
how 34
howard 7 proven
href 2 proven
html 36
http 3 proven
https 58 proven
human 54
humans 68
hunter 13
hunting 3
hurt 1
hygiene 6
hyperlink 3
hyperlinks 12
hypernymy 4 proven
hyphen 30
hyphenate 2
hyphenated 18
hyphenation 17
hyphens 10
i 13
id 17
idea 2
ideal 1
ideas 2
identical 9
identifier 13
identifiers 9
identities 17
identity 78
ideology 1
idiomatic 2
idris 44 proven
ids 10
iec 23 proven
ietf 1
if 69
ignore 2
ignoring 1
image 3
images 1
immediately 1
implement 6
implementation 105
implementations 4
implemented 25
implementer 5 proven
implementers 18 proven
implements 3
implied 1
imply 3
import 10
imports 1
improve 11
improved 2
improvement 66
improves 3
improving 6
impure 2
in 1138
include 37
includes 9
including 41
incompatible 2
incomplete 2
inconsistency 5
inconsistent 6
increase 1
increasing 2
indent 28
indentation 12
independent 34
independently 1
index 9
indicate 10
indispensable 13
individual 2
inductive 3
inference 2
inferred 10
inform 1
information 1
informative 99
ingest 3
ingests 1
inheritance 1
init 7
initial 1
initializes 2
inline 19
input 11
inputs 3
inria 3 proven
insert 2
inserts 3
inside 18
inspiration 4
inspired 5
install 5
installed 2
installing 2
installs 3
instead 6
instruct 2
instructed 2
instruction 2
integer 3
integers 13
integrates 5
integration 73
intended 9
intent 10
intentional 14
intentionally 1
interface 21
interfaces 7
intermediate 9
intermediates 5
internal 3
international 8
interoperability 23
interoperate 2
interpreted 9
interval 1
into 74
introduced 8
introduces 2
invent 54
invented 7
inventing 3
invents 1
inverse 9
inverses 2
invoke 5
invokes 1
io 4
ir 21 proven
is 2010
iso 53 proven
isolation 2
isomorphism 44 proven
issuing 1
it 428
item 80
items 44
iterative 1
its 26
itself 35
itu 41 proven
j 4
jargon 7
job 31
jobs 8
join 2
joining 1
json 4 proven
judged 4
jurisdiction 1
just 14
justfile 2
k 9
keagan 43 proven
keags 40 proven
keep 52
keeping 9
keeps 24
kept 2
kernel 2
key 38
keys 8
keyword 3
keywords 41
kind 3
kinds 3
know 8
known 2
kv 2 proven
l 46
label 8
labeled 4
labeling 1
labels 5
lake 67 proven
lakefile 2
land 3
lang 7
language 176
languageid 58 proven
languageids 2 proven
languages 24
laptop 1
large 5
larger 1
last 1
lasting 1
later 41
latest 12
law 2
lawyerly 2
layer 15
layers 5
layout 13
lcd 5 proven
leading 24
leaf 1
lean 1362 proven
leanprover 2
learning 3
leave 7
leaves 8
leaving 17
left 2
leftover 120
leftovers 2
leftoverunstackphrases 7
legacy 1
legal 10
less 1
lessons 4
let 1
letter 36
lettered 2
letters 15
level 2
leveldb 7 proven
levels 12
lf 19 proven
lib 6
libbeastdb 22 proven
library 27
license 73
licenses 9
light 6
lights 3
like 8
likewise 5
limit 1
limited 1
limits 1
line 194
lineage 1
linear 14
lineencodings 2
lines 46
link 4
linking 26
links 28
linter 14 proven
linux 5 proven
liquid 1
list 70
listed 10
lists 17
literal 1
literals 3
live 102
lived 1
lives 27
living 1
llvm 22 proven
lmdb 7 proven
local 76
location 4
locations 1
lock 15
lockfile 2 proven
locks 16
log 1
logical 6
logically 6
logs 13
long 2
look 5
looks 2
lookup 5
loop 13
loops 2
lowercase 39
lowercased 3
ls 2
m 16
machine 73
machines 3
magenta 4
maintain 6
maintainability 1
maintained 4
maintains 22
major 7
make 6
makes 3
man 1
managed 22
mandatory 19
manifest 1
manual 3
map 13
mapped 3
mapping 25
mappings 2
maps 15
march 8
mark 20
markdown 293 proven
marked 15
marker 10
markers 6
marketing 2
marking 2
marks 4
markup 1
mash 58
mashed 11
mashing 2
match 44
matched 1
matches 25
matching 15
material 3
math 1
mathlib 11
matter 11
matters 10
maximal 1
maximum 1
may 111 proven
mcbride 4 proven
mclelland 29 proven
md 949 proven
mdline 6
mean 2
meaning 149
means 25
meant 10
measures 1
mechanical 23
mechanism 1
meet 1
meeting 10
meets 2
meetup 1
memory 3
mention 4
mentioned 5
mentions 2
merely 2
merge 1
message 3
messages 1
met 4
meta 3 proven
metadata 4
method 6
methods 5
middle 8
midtones 4 proven
might 2
migration 4
migrations 3
minimal 1
minimalism 1
minimum 1
minor 6
mirror 3
mirrors 1
miscellaneous 4
mismatch 1
mismatches 7
missing 7
mit 4
mix 26
mixed 3
mixing 13
mm 1
mmap 9 proven
mode 4
model 85
modeled 1
models 41
modern 1
modes 8
modifiers 9
modify 10
module 59
modules 90
month 1
more 34
morty 5 proven
most 8
move 6
moves 2
moving 1
multi 1
multiple 6
multiplicities 17 proven
multiplicity 24 proven
must 342 proven
mutual 2
n 31
name 178
named 194
names 138
naming 26
narrative 1
nat 1
native 1
natural 27
near 3
nearby 1
nearest 1
need 13
needed 4
needs 5
neither 1
nested 17
nesting 1
network 45
neural 27
never 63
new 32
newline 1
next 21
nickname 1
nix 221 proven
nixos 9 proven
nixpkgs 9 proven
nnnn 104
no 282
noise 1
non 7
noncommercial 12 proven
nonconforming 70 proven
nonzero 2
normal 4
normalized 1
normative 64 proven
not 1809
note 9
noted 1
notes 10
nothing 4
notice 1
noun 3
nouns 1
novel 17
now 1
nul 3 proven
null 1
number 298
numbered 484
numbering 2
numbers 51
numeric 1
o 4
obey 1
obeys 2
object 9
objects 12
observe 6
observed 2
observing 1
obtained 1
occur 1
octal 6
of 730
ofaspell 2
off 1
offense 1
offer 3
offered 2
offers 1
official 32
often 1
old 5
older 2
oled 5 proven
omega 25
omit 1
omitted 2
on 216
once 16
one 119
ongoing 50
only 136
onto 4
open 13
opened 2
opening 1
operate 1
operating 1
operation 1
operations 7
operator 68
operators 1
option 9
optional 66 proven
optionally 1
options 12
or 485
orchestrated 1
order 7
ordered 20
ordering 3
ordinal 1
ordinary 35
org 5
organic 1
organization 3
orientation 1
oriented 2
orients 2
origin 1
original 11
other 82
otherwise 4
out 37
outcome 2
outcomes 1
output 4
outputs 2
outside 34
over 18
overlap 4
overview 1
owed 1
own 14
owned 12
ownership 13
owns 6
p 9
pack 19
package 34
packaged 7
packages 17
packaging 1
packs 1
pad 1
padded 1
padding 1
page 5
pages 22
paid 2
painful 1
pair 17
pairing 1
pairs 4
palette 21
palettes 1
paper 3
papers 2
paragraph 10
paragraphs 1
parallel 28
parallelism 1
parameter 1
parameters 4
paraphrase 1
parentheses 1
parenthetical 12
parr 1
parse 2
parser 1
parses 10
part 6
particularly 5
party 8
pass 18
passed 1
passes 3
past 1
paste 7
pasted 1
pasting 2
patch 7
path 147
paths 14
pattern 14
patterned 1
patterns 1
pdf 29
pdfs 5 proven
peer 1
peering 8
people 9
per 29
perceived 2
percent 1
perform 6
performed 6
performing 1
performs 3
periods 2
permanent 1
permanently 1
permission 10
permits 6
permitted 8
persist 3
persisted 2
persistence 1
persistent 3
persists 5
person 5
personal 7
philosophy 3
phrase 12
phrases 23
phrasing 2
physical 42
pick 4
pin 59
pinned 20
pins 107
pipeline 17
pixels 3
pkgs 6
place 9
placed 2
placement 4
places 6
plain 29
plainlanguage 3
plan 12
planned 30
platform 1
plugin 2
plugins 1
plural 14
plus 35
point 9
pointer 33
pointers 3
points 14
policy 13
populate 4
populated 4
population 1
portable 1
porting 1
positive 3
posix 2 proven
possibility 1
possible 17
practical 1
practice 8
pre 42 proven
precise 1
precision 3
precommit 3 proven
predate 1
predefined 7
predicate 1
prefer 25
preference 1
preferred 4
prefers 2
prefix 20
prefixes 1
preflight 4 proven
premultiplied 3 proven
prepared 1
present 44
presentation 5
presented 2
preserves 2
pretend 2
prevents 3
previous 8
previously 2
primary 40
principles 4
print 14
printable 3
prints 1
prior 52
private 7
probe 2
probes 1
process 44
processes 1
produce 5
produced 1
produces 2
product 349
products 23
producttreeunifies 6
profanity 1
program 44
programming 8
programs 6
progress 2
project 69
projects 5
promised 1
prompt 16
proof 150
proofofkeags 52
proofs 298
proper 2
properties 3
property 4
proposal 8
proposals 16
proposed 4
proposer 1
propositions 10
prose 69
protocol 33
prove 33
proved 9
proven 44
provenance 12
proves 8
provide 5
provided 3
provides 7
proving 9
provisional 12
public 33
publication 45
publish 12
published 83
publishedbasenames 2
publisher 101
publishers 1
publishes 1
pull 1
punctuation 4
pure 87
purity 3
purpose 12
push 10
puts 4
pwd 40
python 12
q 6
qtt 4 proven
quality 3
quantitative 21
quantities 2
quantity 1
quantization 13 proven
quantize 2 proven
question 17
questions 13
quotation 1
quotations 1
quote 4
quotes 5
quoting 2
r 20
raced 1
raise 6
random 3
range 2
ranges 2
rarely 2
rather 34
rationale 4
raw 4
read 109
reader 18
readers 16
readfile 2
readiness 1
readme 58 proven
reads 15
readthedocs 1
ready 68
real 21
reality 20
realization 2
reason 9
reasoning 11
reasons 1
rebalance 3 proven
rebase 1
recipes 1
recommendation 5
recommendations 5
recommended 21 proven
recommends 1
reconcile 2
reconciled 1
reconciles 4
reconstructing 2
record 45
recorded 2
recording 1
records 48
recurse 1
recursive 58
red 16
redefine 1
redefines 3
reduce 2
reduced 6
reduction 4
reenter 1
ref 256
refer 1
reference 10
references 30
reformat 2
reformats 7 proven
refreshes 4
refs 1
refusing 1
regard 3
regex 1
registry 44
regular 2
reintroduce 1
reject 2
rejected 1
rejects 2
relate 2
related 19
relates 8
relation 25
relations 13
relationship 1
relationtype 13 proven
release 25
released 15
releases 6
relevant 2
relicense 1
relied 1
relocate 1
rely 2
remain 60
remaining 33
remains 112
reminder 5
remote 11
remotes 1
rendering 1
rendition 1
renumber 2
renumbers 4
repair 3
repairing 5
repeat 6
repeated 5
repeats 1
rephrase 7
rephrased 12
rephrasing 1
replace 56
replaced 2
replacement 3
replaces 1
replay 1
replication 8
repo 15 proven
report 9
reports 9
repos 4 proven
repositories 1
repository 440
represent 1
representable 8 proven
representation 7
represents 1
republication 3
require 16
required 105 proven
requirement 95
requirements 62
requires 84
requiring 3
research 56
reserved 2
reset 3
reshape 1
reshaping 4
residual 228
resolve 2
resource 2
resources 7
rest 2
restart 1
restate 11
restates 7
restore 1
restricted 2
restriction 1
restricts 1
result 9
resulting 1
retain 4
retrieval 4
return 2
reused 1
reverse 1
review 4
reviewed 5
reviewers 8
revise 3
revising 3
revision 1
revisions 1
rewrites 2
rewriting 1
rfc 157 proven
rfcs 11
rfl 4
rgb 22 proven
rgbcmykw 3 proven
rick 5 proven
ride 1
rides 2
right 2
ring 5
rocksdb 8 proven
role 11
roles 1
root 128
rosetta 47 proven
roughly 1
row 3
rows 9
rsi 175 proven
rst 2
rule 30
ruled 2
rules 131
run 94
runcommand 7
running 2
runs 37
runtime 28
runtimeless 3 proven
rust 49
rustchain 1
s 171
safety 14
said 3
same 142
sandbox 1
sandboxed 1
satisfy 8
say 26
saying 1
says 6
scaled 1
scaling 1
scan 30
scanability 3 proven
scanned 2
scanning 1
scans 13
scc 5 proven
schedule 3
scheduled 2
schema 28
scheme 5
scope 70
scoped 9
script 5
scripts 12
scripture 20
second 62
secondary 3
section 32
sections 9
security 1
see 42
seek 1
seeking 2
seems 1
segment 1
segments 2
select 1
selected 36
selection 4
self 69
sell 10
semantic 31
semantics 2
semver 110 proven
send 1
sends 1
sense 7
sensitive 3
sentence 43
sentences 7
separable 9
separate 68
separated 1
separately 1
separates 1
separators 1
sequence 2
sequential 48
serialize 2
serialized 1
serializing 3
series 12
seriously 31
served 1
services 1
session 12
sessions 1
set 54
sets 7
setting 1
seven 3
sgg 2
sgr 13 proven
shades 4
shall 360 proven
shape 3
shapes 1
share 14
shared 16
sharp 1
shell 30
shim 1
shims 3
shipped 21
ships 3
short 39
should 71 proven
shovel 1
show 2
shown 7
sibling 66
side 1
signal 1
signature 5
signed 17
significantly 5
signing 9
silence 16
silent 3
silently 1
simd 10 proven
similar 16
simple 3
simplify 1
single 24
sit 3
site 2
sits 2
six 1
size 12
skeleton 2
skill 67
skills 54
skip 11
skipped 2
skips 6
slake 192 proven
slash 1
slots 1
slow 2
small 4
smaller 1
smart 27
snake 1
snapshots 2
so 73
society 5
soft 12
software 2
sole 1
solely 1
some 7
something 1
sorry 3
sort 4
sorted 3
sound 1
source 88
sources 13
space 22
spaces 19
span 2
spans 2
sparingly 1
sparse 1
spawn 4
spawning 1
spdx 3 proven
spec 533 proven
special 2
specific 2
specification 820
specifications 271
specified 185
specifies 20
specify 30
specifying 3
specregistry 5
specs 64 proven
speed 1
spelled 2
spelling 80
spirit 4
split 51
splitting 2
sqlite 8 proven
srgb 8 proven
sssp 66 proven
sssss 229 proven
stable 3
stack 75
stackintegrates 3
stacks 1
stage 3
stages 1
staging 1
stale 8
stand 1
standalone 2
standard 18
standardization 2
standards 18
start 14
started 37
starting 1
starts 6
stash 1
state 40
stated 11
statement 3
statements 11
states 26
stating 2
stats 43
status 23
stay 33
stays 15
stderr 3 proven
steal 14
steinberg 13 proven
step 31
steps 5
still 78
stochastic 3 proven
stock 3
stop 7
stopped 1
stopping 2
stops 1
storage 3
store 35
stored 8
stores 6
str 9
straight 4
stream 13
streams 27
stricter 1
strictly 2
string 10
strings 8
strip 1
stripping 2
strips 2
strong 1
stronger 2
strongest 1
strongly 1
structural 5
structure 14
structured 1
structures 6
stuffed 2
style 10
subagent 4 proven
subagents 11 proven
subdirectories 1
subdirectory 5 proven
subject 2
submodule 39 proven
submodules 28 proven
subpixel 4 proven
subsection 17
subset 6
substitute 42
substituting 2
substrate 19
subtitle 1
success 6
such 55
suffix 3
sugar 3
suggested 1
suite 9
summarize 2
summary 3
supercompiler 28 proven
superseded 1
supplies 1
supply 1
support 3
supported 1
surface 12
surfaces 2
surmount 264 proven
surmountspecnumber 4
swear 1
switch 1
swmr 10 proven
symbolic 26
symbols 1
symlink 3
symmetry 4
sync 1
synonymy 3 proven
system 19
systems 444
systemslean 11
t 88
tab 25
table 16
tables 12
tabs 30
tactics 1
tag 6
tagged 1
tags 18
takes 5
taking 31
talk 6
talks 9
target 19
targeting 4
targets 5
task 1
technical 45
technique 1
television 9
tell 5
telling 1
tells 3
temporary 1
ten 3
tends 1
term 1
terminal 7
terminals 2
terms 4
test 37
testing 1
tests 191
text 80
texts 6
th 4 proven
than 77
that 1150
the 2314
theater 3
their 35
them 45
themselves 3
then 38
theology 2
theorem 28
theorems 41
theory 23
there 25
thereafter 1
therefore 2
these 19
they 139
thin 8
thing 3
things 1
third 11
this 1245
thisreposeparates 8
those 285
thought 9
thoughts 10
thread 2
three 22
threshold 3
through 41
throughout 1
throw 6
throwaway 3
thrown 1
tie 3
tight 7
tightly 9
time 27
times 5
tips 2
tired 1
title 10
titled 6
titles 3
to 382
toaspell 2
toc 5 proven
today 1
together 7
toggled 1
token 51
tokenize 4 proven
tokenized 3 proven
tokenizer 4 proven
tokenizes 3 proven
tokens 40
toml 4 proven
tool 54
tooling 12
tools 31
top 4
topic 1
topics 3
torn 2
touch 1
tracked 6
tracking 19
tracks 2
traditional 12
trailing 32
train 2
training 6
trains 6
transactions 3
translates 1
translation 37
translator 1
transparent 2
treat 26
treated 57
treating 13
treats 6
tree 139
trees 70
tricks 1
trie 9 proven
tries 24 proven
trip 1
trips 1
trivial 1
true 56
truly 3
trust 32
truth 5
tt 4 proven
tui 2 proven
turing 4 proven
turn 1
turned 1
tutorial 1
two 60
txt 30 proven
type 34
typecheck 16 proven
typechecking 3 proven
typechecks 39 proven
typed 10
types 14
typically 1
u 9
unacceptable 1
unambiguous 1
unassigned 34
unchanged 1
undated 10
undefined 3
under 244
underlies 1
underscore 3
underscores 2
understand 1
understandable 1
understanding 1
unicode 9
unification 22
unified 1
unifies 5
unify 18
unifying 1
unimplemented 14
unique 24
uniqueness 1
unit 8
units 3
unknown 1
unless 34
unlicense 53 proven
unlicensed 3
unlike 1
unlimited 1
unmarked 1
unmet 5
unnumbered 10
unpinned 10
unpublished 41
unrelated 1
unresponsive 3
unrestricted 17
unsigned 15
unspecified 28
unstable 3
unstack 98 proven
unstage 2
unstated 2
until 3
untracked 1
unused 2
up 3
update 11
updated 3
updates 1
updating 2
uppercase 8
upstream 14
url 31 proven
urls 21 proven
us 29 proven
usa 1
use 240
used 66
useful 1
user 7
users 1
uses 41
using 9
usual 1
usually 1
utf 4 proven
ux 1
v 21
vague 1
valid 7
validation 43
validator 6 proven
validators 3 proven
value 8
values 44
varies 1
vector 7
vectors 1
vendor 19
verb 2
verification 3
verified 36
verify 31
version 68
versioned 3
versioning 45
versions 6
versus 32
via 11
vibefication 194 proven
view 1
viewer 2
views 1
violation 2
violations 1
visibility 1
visible 1
vision 2
vjopn 2
vocab 14
vocabaspell 2
vocabulary 89
vocabularyproofs 10
vocabularyspec 18
vocabularyspecnumber 4
vs 9
w 9
wait 2
warn 1
warning 1
was 26
watch 2
way 6
we 12
weaken 1
weakening 1
weakens 2
weaker 3
web 5
well 3
were 18
wesley 1
wez 1
what 80
when 260
where 8
whether 1
which 25
while 8
white 5
whitespace 94 proven
whitespaceviolations 3
who 8
whole 4
whose 29
why 30
width 2
widths 1
will 14
wins 1
wire 19
with 303
withdrawn 58
withdraws 1
within 4
without 46
word 123
wordid 56 proven
wordids 9 proven
wording 16
wordlist 2 proven
words 85
wordstats 2
work 152
workflow 6
workflows 2
working 2
works 5
would 8
wrap 11
wrapped 8
wrapper 8
wrappers 2
wrapping 24
wraps 2
write 56
writer 13
writers 2
writes 9
writeshellapplication 5
writetext 5
writing 13
written 46
wrong 19
ws 7
www 6
x 21
y 5
yaml 15 proven
year 2
yellow 4
yes 1
yet 9
yield 1
yml 3
you 13
your 1
yourself 3
youtube 4 proven
yyyy 1
yyyymmdd 4
z 9
za 3
zero 2
zerocopy 10 proven
zeros 1
```
