# Drax

[Documentation](https://hexdocs.pm/drax).

Drax provides a few, common CRDTs for building distributed systems. Drax only provides
the data structures themselves and does not provide a means to replicate or
distribute these data structures across your cluster.

## CRDTs provided

### OrSet

State based, Observed-Removed Sets. It supports causal additions and deletions.
In the case of a conflit Add wins. Because this CRDT is state based it requires
that you replicate the entire CRDT to other nodes. This is prohibitive if you
have a large number of elements in the set.

### GCounter

A monotonicly increasing counter, similar to vector clocks.

## Why do we need more CRDTs?

You don't. In all reality you probably want to just use the CRDTs provided in
Lasp. That said, I do have some simple goals for this project:

1) Learn more about how to properly implement and test CRDTs.
2) Provide a limited set of common CRDTs that I think are useful for the majority of projects.
3) Serve as a reference document for how CRDTs work.

## Should I use this in production?

Probably not. But then again you probably shouldn't be building stateful services
anyway so if you're here then you're my kinda people. Look at the code and see
if they do what you need them to do.

## Installation

```elixir
def deps do
  [
    {:drax, "~> 0.1.0"}
  ]
end
```

