# search.py
# ---------
# Licensing Information: Please do not distribute or publish solutions to this
# project. You are free to use and extend these projects for educational
# purposes. The Pacman AI projects were developed at UC Berkeley, primarily by
# John DeNero (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# For more info, see http://inst.eecs.berkeley.edu/~cs188/sp09/pacman.html

"""
In search.py, you will implement generic search algorithms which are called
by Pacman agents (in searchAgents.py).
"""

import util
from util import heappush, heappop
class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
      """
      Returns the start state for the search problem
      """
      util.raiseNotDefined()

    def isGoalState(self, state):
      """
      state: Search state

      Returns True if and only if the state is a valid goal state
      """
      util.raiseNotDefined()

    def getSuccessors(self, state):
      """
      state: Search state

      For a given state, this should return a list of triples,
      (successor, action, stepCost), where 'successor' is a
      successor to the current state, 'action' is the action
      required to get there, and 'stepCost' is the incremental
      cost of expanding to that successor
      """
      util.raiseNotDefined()

    def getCostOfActions(self, actions):
      """
      actions: A list of actions to take

      This method returns the total cost of a particular sequence of actions.  The sequence must
      be composed of legal moves
      """
      util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other
    maze, the sequence of moves will be incorrect, so only use this for tinyMaze
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s,s,w,s,w,w,s,w]

def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.
    Your search algorithm needs to return a list of actions that reaches
    the goal. Make sure that you implement the graph search version of DFS,
    which avoids expanding any already visited states. 
    Otherwise your implementation may run infinitely!
    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:
    print("Start:", problem.getStartState())
    print("Is the start a goal?", problem.isGoalState(problem.getStartState()))
    print("Start's successors:", problem.getSuccessors(problem.getStartState()))
    """
    """
    YOUR CODE HERE
    """
    fringeStack = util.Stack()  # Stack for DFS
    closeSet = set()  # Set to store visited states (CloseSet)

    startingState = problem.getStartState() # Get the starting state

    fringeStack.push((startingState, [])) # Pushing the starting state to the stack

    while not fringeStack.isEmpty():    # Looping through until the stack is empty

        node = fringeStack.pop()   # Popping the top element from the stack and assigning it to node to get the state and actions
        state = node[0]
        actions = node[1]

        if state in closeSet:  # Checking to see if the state is already visited, if yes, then continue
            continue

        closeSet.add(state)

        if problem.isGoalState(state):  # Checking to see if the state is the goal state, if yes, then return the actions
            return actions

        for successor, action, cost in problem.getSuccessors(state):  # Looping through the successors of the state

            if successor not in closeSet:   # Checking to see if the successor is not visited, if yes, then add the action to the actions list and push the successor to the stack
                updatedActions = actions + [action]   # Adding the action to the actions list
                fringeStack.push((successor, updatedActions))
          

    return []




    util.raiseNotDefined()
    

def breadthFirstSearch(problem):
    """
    YOUR CODE HERE
    """
    fringeQueue = util.Queue()  # Queue for BFS
    closeSet = set()    # Set to store visited states (CloseSet)

    startingState = problem.getStartState()

    fringeQueue.push((startingState, []))

    while not fringeQueue.isEmpty():

        node = fringeQueue.pop()
        state = node[0]
        actions = node[1]

        if state in closeSet:
            continue

        closeSet.add(state)

        if problem.isGoalState(state):
            return actions

        for successor, action, cost in problem.getSuccessors(state):

            if successor not in closeSet:
                updatedActions = actions + [action]
                fringeQueue.push((successor, updatedActions))
          

    return []

    util.raiseNotDefined()

def uniformCostSearch(problem):
    """
    YOUR CODE HERE
    """
    fringePriorityQueue = util.PriorityQueue()  # Priority Queue for UCS
    closeSet = set()

    startingState = problem.getStartState()

    fringePriorityQueue.push((startingState, [], 0), 0)

    while not fringePriorityQueue.isEmpty():

        node = fringePriorityQueue.pop()
        state = node[0]
        actions = node[1]
        cost = node[2]

        if state in closeSet:
            continue

        closeSet.add(state)

        if problem.isGoalState(state):
            return actions

        for successor, action, stepCost in problem.getSuccessors(state):

            if successor not in closeSet:
                updatedActions = actions + [action]
                updatedCost = cost + stepCost # Adding the step cost to the cost
                fringePriorityQueue.push((successor, updatedActions, updatedCost), updatedCost)
    util.raiseNotDefined()

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """
    YOUR CODE HERE
    """
    fringePriorityQueue = util.PriorityQueue()  # Priority Queue for A*
    closeSet = set()
    
    startingState = problem.getStartState()

    fringePriorityQueue.push((startingState, [], 0), 0)
    
    while not fringePriorityQueue.isEmpty():
          
          node = fringePriorityQueue.pop()
          state = node[0]
          actions = node[1]
          cost = node[2]
          
          if state in closeSet:
              continue
          
          closeSet.add(state)
          
          if problem.isGoalState(state):
              return actions
          
          for successor, action, stepCost in problem.getSuccessors(state):
              
              if successor not in closeSet:
                  updatedActions = actions + [action]   # Adding the action to the actions list
                  updatedCost = cost + stepCost   # Adding the step cost to the cost
                  updatedCostWithHeuristic = updatedCost + heuristic(successor, problem)    # Adding the heuristic cost to the updated cost
                  fringePriorityQueue.push((successor, updatedActions, updatedCost), updatedCostWithHeuristic)
                  # Pushing the successor, updated actions and updated cost to the priority queue
    return []
    util.raiseNotDefined()


# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
